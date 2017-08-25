# Spreadsheet Reader requests the spreadsheet data from Google,
# receives it, formats it, and returns it to caller.
module SpreadsheetReader
  # Adapted from gimite (Hiroshi Ichikawa) with thanks
  # https://github.com/gimite/google-drive-ruby

  require 'rubygems'
  require 'google_drive'
  require 'json'
  require 'English'

  @session = nil

  @all_ru_column_headings =
    %i[ru_number on_now? secret_number outside_inside
       category_tag long_description business_hours_only? ru_or_nr
       swiss_cheese would_make_me_happy? priority create_date finishable?
       g_or_r project? bucket_list? priority_notes evernote_note
       link_1 link_2 link_3]

  @ru_number_ind = 0
  @outside_inside_ind = 3
  @long_description_ind = 5

  # Returns spreadsheet data, or false if we need authentication
  def self.sheet_data
    access_token = Token.last.try(:fresh_token)
    return false unless access_token
    @session = GoogleDrive.login_with_oauth(access_token)

    sheet_key = ENV['TEST_RU_SHEET_KEY']
    headings = @all_ru_column_headings

    # worksheets[0] is first worksheet
    # LIVE_RU_SHEET_KEY is the live one
    # TEST_RU_SHEET_KEY is the test one
    begin
      ws = @session.spreadsheet_by_key(sheet_key).worksheets[0]
    rescue StandardError => e
      puts 'I am in rescue!'
      puts $ERROR_INFO.to_s
      puts e.Message
      puts e.backtrace.inspect
    end
    # Return the spreadsheet data by rows
    # As: [["fuga", "baz", "gleep"], ["foo", "bar", "zump"]]
    data_as_array = ws.rows
    SpreadsheetReader.convert_data_to_objects(data_as_array, headings)
  end

  def self.convert_data_to_objects(data_as_array, headings)
    rows = []
    first_row = true
    # Note that first row is column headings
    data_as_array.each do |row_array|
      if first_row
        first_row = false
        next
      end
      ru_item = RuItem.new(row_array[@ru_number_ind], row_array[@outside_inside_ind],
        row_array[@long_description_ind])
       rows << ru_item
    end
    rows
  end

  # Method not used, keeping it around for now
  def self.convert_data(data_as_array, headings)
    hashes_array = []
    # Note that first row is column headings
    data_as_array.each do |row_array|
      data_hash = {}
      i = 0
      row_array.each do |cell_string|
        data_hash[headings[i]] = cell_string
        i += 1
      end
      hashes_array << data_hash
    end
    hashes_array
  end
end
