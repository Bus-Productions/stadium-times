class DeviceTokensController < ApplicationController  

  # POST /device_tokens
  # POST /device_tokens.json
  def create

    if params[:sk] != 'foeiuh9q28734gfa9w8hfg92830rq892g0oaw8hf'
      return
    else

      @device_token = DeviceToken.find_or_initialize_by_ios_device_token(params[:device_token][:ios_device_token])
      @device_token.assign_attributes(params[:device_token])

      respond_to do |format|
        if @device_token.save
          format.html { redirect_to @device_token, notice: 'Device token was successfully created.' }
          format.json { render json: @device_token, status: :created, location: @device_token }
        else
          format.html { render action: "new" }
          format.json { render json: @device_token.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PUT /device_tokens/1
  # PUT /device_tokens/1.json
  def update

    if params[:sk] != 'foeiuh9q28734gfa9w8hfg92830rq892g0oaw8hf'
      return
    else

      @device_token = DeviceToken.find_or_initialize_by_ios_device_token(params[:device_token][:ios_device_token])

      respond_to do |format|
        if @device_token.update_attributes(params[:device_token])
          format.html { redirect_to @device_token, notice: 'Device token was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @device_token.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  
end
