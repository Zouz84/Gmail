require 'google_drive'
require_relative 'Scraaping'
require 'json'
require 'csv'
require 'gmail'
require 'open-uri'

#On défini une variable globale $data qui prend le hash qui contient les noms de villes et adresses mails (qui a été fait dans "Scraaping.rb") 
$data = get_hash
$gmail = Gmail.connect("salutkochanie@gmail.com", "Poland1234")

# On crée une méthode qui appelle drive et configure la spreadsheet qu'on a ouvert précédemment via google drive (ici nommée "Coucou")

def setup_spreadsheet
  session = GoogleDrive::Session.from_config("config.json")
  $ws = session.spreadsheet_by_title("Kikou").worksheets[0]
  $ws[1, 1] = "Mairie"
  $ws[1, 2] = "Adresse mail"
  $ws.save
$ws.reload
end

# On crée une méthode qui récupère le hash et l'imprime sur un googledrive.
# On a précédemment fixé MAirie et Adresse mail sur la premiere ligne des deux premeires colonnes $ws[1,1]= "Mairies"
# Du coup on sait que l'on va partir de la deuxieme ligne donc i = 2.
# En demandant que pour chaque KEY du hash get_hash, on va mettre le Key du hash ligne i, colonne 1. Et en ligne i colonne 2, on rentre la ligne i colonne 1 du hash $data.
def upload_hash
	setup_spreadsheet
	i = 2
	$data.keys.each do |key|
	$ws[i,1] = key
	$ws[i,2] = $data[$ws[i,1]]  
	i += 1 
	end
  $ws.save	
end

# On appelle la dernière méthode: upload_hash afin que tout ça apparaisse dans notre fichier en ligne.
upload_hash

