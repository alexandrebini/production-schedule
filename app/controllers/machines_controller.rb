class MachinesController < ApplicationController
  def index
    @machines = Machine.all
  end

  def show
    @machine = Machine.find(params[:id])
  end

  def new
    @machine = Machine.new
  end

  def edit
    @machine = Machine.find(params[:id])
  end

  def create
    @machine = Machine.new(params[:machine])

    if @machine.save
      redirect_to(@machine, :notice => 'Machine was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @machine = Machine.find(params[:id])

    if @machine.update_attributes(params[:machine])
      redirect_to(@machine, :notice => 'Machine was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @machine = Machine.find(params[:id])
    @machine.destroy

    redirect_to(machines_url)
  end
end
