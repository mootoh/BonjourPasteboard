#
#  daemon.rb
#  RemoteShortcutsMac
#
#  Created by Motohiro Takayama on 5/28/09.
#  Copyright (c) 2009 deadbeaf.org. All rights reserved.
#
require "socket"

class Daemon < OSX::NSObject
   DAEMON_PORT  = 12345
   
   ib_outlet :menus, :window, :customize_field

   def quit(sender)
      OSX::NSApplication.sharedApplication.terminate nil
   end

   def toggle(sender)
      if @is_working
         @net_service.stop
         @menu.setImage icon_images[1]
         @menu.setToolTip 'RemoteShortcuts is OFF'
         sender.setTitle 'ON'

      else
         @net_service.publish
         @menu.setImage icon_images[0]
         @menu.setToolTip 'RemoteShortcuts is ON'
         sender.setTitle 'OFF'
      end
      @is_working = ! @is_working;
   end

   def open_customize_window(sender)
   	@window.makeKeyAndOrderFront self
   end
   
   def customize_shortcuts(sender)
      @customize_field.setStringValue 'press shortcut keys'
      @customize_field.becomeFirstResponder
   end

   ib_action :quit
   ib_action :toggle
   ib_action :open_customize_window
   ib_action :customize_shortcuts

   def icon_images
      unless @s_icon_images
         bundle = OSX::NSBundle::mainBundle;
         
         paths = [
            bundle.pathForResource_ofType("activated", "png"),
            bundle.pathForResource_ofType("deactivated", "png")]
         @s_icon_images = paths.collect do |path|
            OSX::NSImage.alloc.initByReferencingFile(path)
         end
      end
      return @s_icon_images
   end
   
   def applicationDidFinishLaunching(notification)
      @is_working = true
      @window.setReleasedWhenClosed false
      @clients = []

      hotkey_handler = OSX::HotkeyHandler.new
      hotkey_handler.daemon = self;
      hotkey_handler.setupHotkey
       
      bar = OSX::NSStatusBar.systemStatusBar
      @menu = bar.statusItemWithLength(24).retain
      @menu.setImage(icon_images[0])
      @menu.setToolTip('RemoteShortcuts')
      @menu.setHighlightMode true
      @menu.setMenu @menus

      @net_service = OSX::NSNetService.alloc.initWithDomain_type_name_port('', '_wwdcpic._tcp', '', DAEMON_PORT)
      @net_service.setDelegate(self)
      @net_service.publish

      Thread.new { start_daemon_thread }
   end
   
   def start_daemon_thread
      gs = TCPServer.open(DAEMON_PORT)
      addr = gs.addr
      addr.shift

      while true
         Thread.start(gs.accept) do |s|       # save to dynamic variable
            @clients.push s
            while msg = s.read(4)
               puts "passcode = #{msg}"
               s.write($_)
            end
            s.close
            @clients.delete(s)
         end
      end
   end

   #
   # NSNetService
   #
   def netServiceWillPublish(sender)
   end
   
   def netService_didNotPublish(sender, errorDict)
      if errorDict[OSX::NSNetServicesErrorCode].to_i == OSX::NSNetServicesCollisionError
         puts 'A name collision occurred. A service is already running with that name someplace else.'
      else
         puts 'Some other unknown error occurred.'
      end
      
      @netService = nil
   end
   
   def netServiceDidStop(sender)
      @net_service = nil
   end

   # get string from Pasteboard, then send it to clients
   def trigger
      pb = OSX::NSPasteboard.generalPasteboard
      pb.availableTypeFromArray [OSX::NSStringPboardType]
      pb_string = pb.stringForType(OSX::NSStringPboardType)
      
      @clients.each do |client|
         client.write [sprintf("%04d", pb_string.lengthOfBytesUsingEncoding(OSX::NSUTF8StringEncoding)), pb_string.UTF8String].join(',')
      end
   end

end # Daemon