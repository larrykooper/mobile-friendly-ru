# The Spreadsheets Controller is executed when the user enters the app.
# It asks for data from Google.
class SpreadsheetsController < ApplicationController
  def getdata
    begin
      @rows = SpreadsheetReader.sheet_data
    rescue
      redirect_to '/auth/google_oauth2' and return
    end

    respond_to do |format|
      format.html { render 'spreadsheets/index' }
      format.json { render json: @rows }
      format.text { render text: @rows }
    end
  end
end
