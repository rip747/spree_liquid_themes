class Theme

  THEME_PATH = Rails.root.join "themes"

  class << self

    def all
      Dir.glob(File.join(THEME_PATH, "*")).collect { |dir|
        dir = dir.split("/").last
        [config_for(dir)["theme"]["name"], dir]
      }
    end

    def config_for(key)
      YAML::load(File.open(File.join(THEME_PATH, key, "config", "config.yml")))
    end

    def layouts_for(key)
      layouts_list(File.join(THEME_PATH, key, "layouts", "*.liquid"))
    end

    def templates_for(key)
      templates_list(File.join(THEME_PATH, key, "templates", "*.liquid"))
    end

    private

=begin
    def cms_templates_list(path)
      cms_temlates = []
      Dir.glob(path).collect { |file|
        segments = file.split("/")
        if segments.last =~/^cms_.*.liquid$/
          file = segments.last.gsub(/.liquid/, "")
          cms_temlates << ["#{file.humanize}", file]
          #segments[-2].singularize
        end
      }

      cms_temlates
    end
=end
    def layouts_list(path)
      Dir.glob(path).collect { |file|
        segments = file.split("/")
        file = segments.last.gsub(/.liquid/, "")
        ["#{file.humanize}", file]
      }
    end

    def templates_list(path)
      Dir.glob(path).collect { |file|
        segments = file.split("/")
        file = segments.last.gsub(/_template.liquid/, "")
        ["#{file.humanize}", file]
      }
    end

  end

  attr_reader :feed_path

  def initialize(key, opts = nil)
    @path = File.join(THEME_PATH, key)
    @config_path = File.join(@path, "config")
    @layout_path = File.join(@path, "layouts")
    @template_path = File.join(@path, "templates")
    @partial_path = File.join(@path, "partials")
    @feed_path = File.join(@path, "feeds")
    @image_path = File.join(@path, "images")
    @stylesheet_path = File.join(@path, "stylesheets")
    @javascript_path = File.join(@path, "javascripts")
    #parse(opts) if opts
    if opts
      @template_raw = File.read(File.join(@template_path, "#{opts[:template]}_template.liquid")) if opts[:template]
      @layout_raw = File.read(File.join(@layout_path, "#{opts[:layout]}.liquid"))
    end
  end

  def image(file_path)
    File.join(@image_path, file_path)
  end

  def javascript(file_path)
    File.join(@javascript_path, file_path)
  end

  def stylesheet(file_path)
    File.join(@stylesheet_path, file_path)
  end

  def config
    file = File.join(@config_path, "config.yml")
    YAML::load(File.open(file)) if File.exist?(file)
  end

  def default_assigns(str)
    yaml = YAML::load(str)["assigns"] || false
    return {} unless yaml
    assigns = extract_assigns(yaml, :vars)
    extract_assigns(yaml, :collections).each do |k, v|
      assigns[k] = Collection.find_by_key v
    end
    return assigns
  end

  def layout_raw
    @layout_raw
  end

  def template_raw
    @template_raw
  end

  def file_system
    Liquid::Template.file_system = Liquid::LocalFileSystem.new(@partial_path)
  end

  private

=begin
  def parse(opts)
   # @template = Liquid::Template.parse(File.read(File.join(@template_path, "#{opts[:template]}_template.liquid"))) if opts[:template]
    #@layout = Liquid::Template.parse(File.read(File.join(@layout_path, "#{opts[:layout]}.liquid")))
  end
=end

  def extract_assigns(assigns, key)
    key = key.to_s
    defaults = assigns['defaults'] && assigns['defaults'][key] ? assigns['defaults'][key] : {}
    layouts = assigns['layouts'] && assigns['layouts']['default'] && assigns['layouts']['default'][key] ? assigns['layouts']['default'][key] : {}
    templates = assigns['templates'] && assigns['templates']['page'] && assigns['templates']['page'][key] ? assigns['templates']['page'][key] : {}
    defaults + layouts + templates
  end

end
