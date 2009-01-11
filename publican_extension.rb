require 'action_controller/dispatcher'
require 'publican'

class PublicanExtension < Radiant::Extension
  version "1.0"
  description "Automatically copy extension public files on every load for the development environment"
  url "http://github.com/freelancing-god/radiant-publican"
    
  def activate
    return unless RAILS_ENV == "development"
    
    ActionController::Dispatcher.to_prepare :publican do
      Publican.another_round
    end
  end
end