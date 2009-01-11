class Publican
  ExtensionPaths = File.join RAILS_ROOT, "vendor", "extensions", "*"
  
  def self.another_round
    ActionController::Base.logger.add(
      Logger::DEBUG, "\n  Publican: Serving another round of public files"
    )
    
    Dir[ExtensionPaths].each do |extension|
      Dir[File.join(extension, "public", "**", "*")].each do |file|
        next if svn_or_dir?(file)
        
        path      = file.sub(extension, '')
        directory = File.dirname(path)
        
        FileUtils.mkdir_p File.join(RAILS_ROOT, directory)
        FileUtils.cp file, File.join(RAILS_ROOT, path)
      end
    end
  end
  
  private
  
  def self.svn_or_dir?(path)
    path =~ /\.svn/ || File.directory?(path)
  end
end