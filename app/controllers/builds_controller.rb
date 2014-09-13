class BuildsController < ApplicationController
  before_action :set_build, only: [:show, :edit, :update, :destroy]

  # GET /builds
  # GET /builds.json
  def index
    @builds = Build.all
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
  end

  # GET /builds/new
  def new
    @build = Build.new
  end

  # GET /builds/1/edit
  def edit
  end

  # POST /builds
  # POST /builds.json
  def create
    @build = Build.new(build_params)

    respond_to do |format|
      if @build.save
        if(@build.buildFilePath.file.exists?)
          #Read ipa or apk here
          extension = File.extname(@build.buildFilePath.url)
          if (extension == ".ipa")
            format.html { redirect_to @build, notice: 'Build was successfully created. And IPA uploaded' }
            # puts @build.buildFilePath.url
            ipa = Lagunitas::IPA.new(Dir.pwd + '/public' + @build.buildFilePath.url)
            app = ipa.app     #=> Lagunitas::App

              # Get information about the app
            puts app.identifier    #=> com.samsoffes.Sample
            puts app.display_name  #=> Sample
            puts app.version       #=> 13
            puts app.short_version #=> 2.2
              # Remove unzipped app
            ipa.cleanup

            manifestObj = {'items' => 
                            [{ 'assets' => 
                              [{'kind' => 'software-package', 
                                'url' =>'https://192.168.1.62:3001' + @build.buildFilePath.url }],
                              'metadata' =>
                               {'bundle-identifier' =>  app.identifier,
                               'bundle-version' => app.short_version,
                               'kind' => 'software',
                               'title' => app.display_name}

                            #   ], {'bundle-identifier' =>  app.identifier, 
                            #     'bundle-version' => app.version,
                            #     'kind' => 'software',
                            #     'title' => app.display_name}
                            }]
                          }
            # puts @build.buildFilePath.
            str = @build.buildFilePath.url
            list = str.split('/')
            path = '/public' + list[0..list.count-2].join('/') + '/manifest.plist'
            puts path
            # pathList = @build.buildFilePath.url
            # directory = 
            File.open(Dir.pwd + path, 'w') {|f| f.write(Plist::Emit.dump(manifestObj)) }



          elsif (extension == ".apk")            
            format.html { redirect_to @build, notice: 'Build was successfully created. And APK uploaded' }
          else
            format.html { redirect_to @build, notice: 'Build was successfully created. And file uploaded' }
          end
        else
          format.html { redirect_to @build, notice: 'Build was successfully created. But no file is uploaded' }
        end
        format.json { render :show, status: :created, location: @build }
      else
        format.html { render :new }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /builds/1
  # PATCH/PUT /builds/1.json
  def update
    respond_to do |format|
      if @build.update(build_params)
        format.html { redirect_to @build, notice: 'Build was successfully updated.' }
        format.json { render :show, status: :ok, location: @build }
      else
        format.html { render :edit }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build.destroy
    respond_to do |format|
      format.html { redirect_to builds_url, notice: 'Build was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build
      @build = Build.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_params
      params.require(:build).permit(:number, :version, :releaseNotes, :platform, :buildIdenifier, :accessToken, :domain, :provision, :displayname, :icon, :buildFilePath)
    end
end
