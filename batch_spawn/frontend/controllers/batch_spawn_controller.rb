class BatchSpawnController < ApplicationController

  set_access_control  "update_resource_record" => [:index,:batch_spawn, :create, :new]
  set_access_control  "manage_repository" => [:index,:batch_spawn, :create, :new]
									
  def index
    @page = 1
    @records_per_page = 10

    flash.now[:info] = I18n.t("plugins.lcnaf.messages.service_warning")
  end
  
  def new
  
  Log.debug("NEW")
    return render_aspace_partial :partial => "resources/new_inline" if params[:inline]
  
  end
  					
  def create 
  
  Log.debug("ONE MOPRE TIME")
   accession_url = params[:target] 
   accession_id = accession_url.split('/').last
   
  Log.debug(accession_id)
   @resource = Resource.new(:title => I18n.t("resource.title_default", :default => ""))._always_valid!
   
   acc = Accession.find(accession_id, find_opts)
 Log.debug("HERE")
 Log.debug(acc)
 
   #@resource.populate_from_accession(acc)
 #Log.debug(@resource)
  # flash.now[:info] = I18n.t("resource._frontend.messages.spawned", JSONModelI18nWrapper.new(:accession => acc))
   #flash[:spawned_from_accession] = acc.id
   
    #flash.keep(:spawned_from_accession)
	
    render :json => accession_id.to_json
      #render :json => {'job_uri' => url_for(:controller => :jobs, :action => :show, :id => response['id'])}
   # return render_aspace_partial :partial => "resources/new_inline" if params[:inline]
    #handle_crud(:instance => :resource,
         #       :on_invalid => ->(){
         #         render action: :new
         #       },
         #       :on_valid => ->(id){
         #         redirect_to({
         #                       :controller => :resources,
         #                       :action => :edit,
         #                       :id => id
          #                    },
           #                   :flash => {:success => I18n.t("resource._frontend.messages.created", JSONModelI18nWrapper.new(:resource => @resource))})
            #     })
  end
  def batch_spawn
  
  Log.debug("starter")
  
  Log.debug("ONE MOPRE TIME")
   accession_url = params["_resolved"]["id"] 
  Log.debug( params["_resolved"]["id"]  )
   accession_id = accession_url.split('/').last
   
  Log.debug( accession_id )
	
    render :json => accession_id.to_json
  end
  
end