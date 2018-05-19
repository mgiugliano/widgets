stylingOptions =
  # background color
  background: 'rgba(#fff, 0.01)' # was 0.2
  # show fullscreen -> true
  fullscreen: false
  # display position 'top', 'middle', 'bottom'
  vertical: 'top'

dateOptions =
  # display not only 'time' also 'date'
  showDate: false
  # format of 'date'
  date: '%a %d/%m/%Y'

format = (->
  if dateOptions.showDate
    dateOptions.date + '\n' +'%H:%M' # was dateOptions.date + '\n' +'%l:%M %p'
  else
    '%H:%M' # was '%l:%M %p'
)()

command: "date +\"#{format}\""

# the refresh frequency in milliseconds
refreshFrequency: 60000

# for update function
dateOptions: dateOptions

render: (output) -> """
  <div id='simpleClock'>#{output}</div>
"""

update: (output) ->
  if this.dateOptions.showDate
    data = output.split('\n')

    html = data[1]
    html += '<span class="date">'
    html += data[0]
    html += '</span>'

  else
    html = output

  $(simpleClock).html(html)

style: (->
  fontSize = '8em'
  width = 'auto'
  transform = 'auto'
  bottom = '3%'
  top = 'auto'

  if stylingOptions.fullscreen
    fontSize = '10em'
    width = '94%'

  if stylingOptions.vertical is 'middle'
    transform = 'translateY(50%)'
    bottom = '50%'
  else if stylingOptions.vertical is 'top'
    bottom = 'auto'
    top = '1%'

  return """
    background: #{stylingOptions.background}
    color: #FFFFFF
    font-family: Helvetica Neue
    left: 36%
    top: #{top}
    bottom: #{bottom}
    transform: #{transform}
    width: #{width}

    #simpleClock
      font-size: #{fontSize}
      font-weight: 100
      margin: 0
      text-align: center
      padding: 10px 20px

    #simpleClock .date
      margin-left: .5em
      font-size: .5em
  """
)()
