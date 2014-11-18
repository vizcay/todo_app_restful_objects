require 'fssm'

desc 'start local webserver at localhost:9090 only frontend'
task :frontend_server do
  system 'ruby -run -e httpd public/ -p 9090'
end

desc 'build frontend (haml, sass, coffee)'
task :build_frontend do
  Dir.glob('frontend/haml/*.haml').each do |file|
    next if File.basename(file)[0] == '_'
    compile_haml file
  end
  Dir.glob('frontend/sass/*.scss').each do |file|
    compile_sass file
  end
  Dir.glob('frontend/coffee/**/*.coffee').each do |file|
    compile_coffee file
  end
end

desc 'clean built frontend assets'
task :clean_frontend do
  built_assets.each do |file|
    execute_and_print "rm \"#{file}\""
  end
end

desc 'watch frontend haml, scss & coffee files to recompile'
task :frontend_autocompile do
  FSSM.monitor(File.dirname(__FILE__), 'frontend/**/*.{haml,coffee,scss}') do
    update do |base, relative|
      input = "#{base}/#{relative}"
      case File.extname(relative)
        when '.haml'
          input = "#{base}/haml/index.haml" if relative =~ /partials/
          compile_haml input
        when '.scss'
          compile_sass input
        when '.coffee'
          compile_coffee input
      end
    end
  end
end

def compile_haml(file)
  output  = "public/#{File.basename(file).gsub!('.haml', '.html')}"
  command = "haml \"#{file}\" \"#{output}\""
  execute_and_print command
end

def compile_sass(file)
  output  = "public/css/#{File.basename(file).gsub!('.scss', '.css')}"
  command = "sass --no-cache \"#{file}\" \"#{output}\""
  execute_and_print command
end

def compile_coffee(file)
  command = "coffee -o \"public/js\" -c \"#{file}\""
  execute_and_print command
end

def execute_and_print(command)
  puts command
  system command
end

def built_assets
  Dir.glob('public/*.html') + Dir.glob('public/css/*.css') + Dir.glob('public/js/*.js')
end

