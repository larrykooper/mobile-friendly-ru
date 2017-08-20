class SpreadsheetsController < ApplicationController

  def getdata

    @data = SpreadsheetReader.get_sheet_data
    unless @data
      redirect_to '/auth/google_oauth2' and return
    end

    respond_to do |format|
      format.html {
        render 'spreadsheets/index'
      }
      format.json {
          render json: @data
      }
      format.text {
          render :text => @data
      }
    end
  end

end
