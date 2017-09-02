# The Spreadsheets Controller is executed when the user enters the app.
# It asks for data from Google.
class SpreadsheetsController < ApplicationController
  def getdata
    @rows = SpreadsheetReader.sheet_data
    unless @rows
      redirect_to '/auth/google_oauth2' and return
    end

    respond_to do |format|
      format.html { render 'ru_items/index' }
      format.json { render json: @rows }
      format.text { render text: @rows }
    end
  end
end
