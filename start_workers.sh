rake resque:work[ENV['QUEUE'] ||= '*']