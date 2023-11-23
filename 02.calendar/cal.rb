#!/usr/bin/env ruby
# frozen_string_literal: true

# ここからコードを記述します
require 'date'
require 'optparse'

def display_calendar(year, month)
  # 指定された年月の最初の日を取得
  first_day = Date.new(year, month, 1)
  today = Date.today

  # 指定された年月のカレンダーを表示
  puts first_day.strftime('%B %Y')
  puts 'Su Mo Tu We Th Fr Sa'

  # 最初の日の曜日までスペースを表示
  print '   ' * first_day.wday

  # 月の最終日まで日付を表示
  (first_day..first_day.next_month.prev_day).each do |date|
    # 背景色と文字色を反転
    print "\e[0;7m" if date == today
    
    #スペース一個分横も塗りつぶされていたので修正
    date_str = date.day.to_s.rjust(2)
    date_str = "\e[0;7m#{date_str}\e[0m" if date == today
    print "#{date_str} "

    # 土曜日まで表示したら改行
    puts if date.wday == 6
    # 当日以外の日付で文字色が反転している部分を元に戻す
    if date == today
      print "\e[0m" # 色を元に戻す
    end
  end

  puts
end

options = {}
OptionParser.new do |opts|
  opts.on('-mMONTH', Integer) do |month|
    options[:month] = month
  end

  opts.on('-yYEAR', Integer) do |year|
    options[:year] = year
  end
end.parse!

# 引数から指定された年と月を取得,Timenowで指定がない時は当日を表示
year = options[:year] || Time.now.year
month = options[:month] || Time.now.month

display_calendar(year, month)
