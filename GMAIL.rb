require 'gmail'
require 'mail'
require 'google_drive'
require 'pry'

#Create a variable worksheet key with the key to access the google spreadsheet (on the related google drive)
# $mail connects to the allowed Gmail Account
worksheet_key = "1sbSgCiGY32YM6OJinyM91_Mc4lZoCfIlr_Z61nn-H80"
$gmail = Gmail.connect("USERNAME", "PASSWORD") # this can be changes with your logs


		#Create a methode to access the worksheet (through its keyà) on google drive => Using the Json file to log
		def get_worksheet(worksheet_key)

				$session = GoogleDrive::Session.from_config("config.json")
				$ws = $session.spreadsheet_by_key(worksheet_key).worksheets[0]

		end

		# go through all the line of the column of the worksheet 
		def go_through_all_the_lines(worksheet_key)


				# create an array called data in order to store all the emails
				data = []
				worksheet = get_worksheet(worksheet_key)

				# for each of line of the row we add it into the "data array"

				worksheet.rows.each do |row|

	 			data << row[1].gsub(/[[:space:]]/, '')
 		 end 
    
    			return data
		end

		# send email methode (and the key as variable)

		def send_gmail_to_listing(worksheet_key)


				# first we connect to gmail with the $gmail variable (where our logs are stored)
				$gmail
				#we go through each email adresse 
				# send we send (deliver) an email with subject + body

					go_through_all_the_lines(worksheet_key).each do |email|
						$gmail.deliver do
      			to email
      			subject "Coucou c'est nous" # write your subject here
      						text_part do 
      			body "Bonjour, vous ne connaissez pas encore The hacking projet? Leurs méthodes vont vous étonner! Visitez leur site: https://www.thehackingproject.org/" 	#write your message here
      				end
      					end
 		 					end

		end
		send_gmail_to_listing(worksheet_key)
