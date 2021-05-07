require_relative "film"
require_relative "film_collection"
require 'open-uri'
require 'nokogiri'
require 'byebug'

module FilmParser
  extend self

  URL = 'https://www.kinonews.ru/top100/'

  def from_kinonews
    doc = Nokogiri::HTML(open_page(URL))

    names =
      doc.css('div.bigtext').map do |node|
        node.text.gsub(/\s\d+\.\s/,'').gsub(/, \d{4}/, '')
      end

    years =
      doc.css('div.bigtext').map do |node|
        node.text.split(" ").last
      end

    directors =
      doc.css('.textgray').filter_map do |node|
        if node.css('span').text == "Режиссер:"
          a = node.css('a')
          a.count > 1 ? a[1].text : a.text
        end
      end.compact

    films =
      [names, directors, years].
      transpose.
      filter_map do |data|
        Film.new(data[0], data[1], data[2]) unless data[1].empty?
      end

    FilmCollection.new(films)
  end

  private

  def open_page(url)
    URI.open(url)
  end
end
