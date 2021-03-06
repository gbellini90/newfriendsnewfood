class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy]

def index
  @groups= Group.all
end

def show
  @users=User.all
  @reservations =Reservation.all
end

def new
  @group = Group.new
end

def create
  @group=Group.create(group_params)
  if @group.valid?
    redirect_to group_path(@group)
  else
    flash[:errors] = @group.errors.full_messages
    redirect_to new_group_path
  end
end

def edit
end

def update
  if @group.update(group_params)
    redirect_to group_path(@group)
  else
    flash[:errors] = @group.errors.full_messages
    redirect_to edit_group_path
  end
end

def destroy
  @group.destroy
  redirect to groups_path
end

private

def find_group
  @group = Group.find(params[:id])
end

def group_params
  params.require(:group).permit(:name)
end

end
