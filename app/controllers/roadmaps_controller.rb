class RoadmapsController < ApplicationController
  def index
    @roadmaps = Roadmap.all
  end

  def show
    @roadmap = Roadmap.find(params[:id])
  end

  def new
    @roadmap = Roadmap.new
  end

  def edit
    @roadmap = Roadmap.find(params[:id])
  end

  def create
    @roadmap = Roadmap.new(params[:roadmap])

    if @roadmap.save
      redirect_to(@roadmap, :notice => 'Roadmap was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @roadmap = Roadmap.find(params[:id])

    if @roadmap.update_attributes(params[:roadmap])
      redirect_to(@roadmap, :notice => 'Roadmap was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @roadmap = Roadmap.find(params[:id])
    @roadmap.destroy

    redirect_to(roadmaps_url)
  end
end
