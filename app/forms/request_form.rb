class RequestForm
  RequestInvalid = Class.new(StandardError)

  def initialize(request_data)
    @token   = request_data[:token]
    @command = request_data[:command]
    @text    = format_text(request_data[:text].split(' '))
  end
  attr_reader :token, :command, :text

  def validate!
    raise RequestInvalid unless command_valid? && text_valid?
  end

  private

  def token_valid?
    token == ENV['SLACK_TOKEN']
  end

  def command_valid?
    command == '/trello'
  end

  def text_valid?
    text.length >= 3
  end

  def format_text(text)
    {
      board_name: text[0],
      list_name:  text[1],
      card_title: text[2],
      card_desc:  text[3]
    }
  end
end