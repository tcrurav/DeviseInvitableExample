class Users::InvitationsController < Devise::InvitationsController
  def new
    logger.info("hola caracola")
    super
  end

  def create
    super
  end

  def edit
    logger.info("edit hola caracola")
    super
  end

  def update
    # if some_condition
    #   redirect_to root_path
    # else
      super
    # end
  end
end