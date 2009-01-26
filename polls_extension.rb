class PollsExtension < Radiant::Extension
  version "0.2"
  description "Radiant gets polls."
  url "http://github.com/nuex/radiant-polls-extension"
  
  define_routes do |map|
    map.resources :poll_response, :path_prefix => "/pages/:page_id", :controller => "poll_response"
    map.resources [:admin,:polls]
  end
  
  def activate
    admin.tabs.add "Polls", "/admin/polls", :after => "Layouts", :visibility => [:all]
    SiteController.class_eval{
      session :disabled => false
    }
    Page.send :include, PollTags
    Page.send :include, PollProcess
  end
  
  def deactivate
    admin.tabs.remove "Polls"
  end
  
end
