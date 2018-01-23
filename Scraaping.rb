require 'rubygems'
require 'nokogiri'   
require 'open-uri' 

$data = Hash.new

# On crée une méthode qui récupère tous les liens des mairies
def get_all_the_urls_of_val_doise_townhalls

# On initialise une variable globale ($) array, dans laquelle on stockera les bouts de lien
  page_townhal = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")) 

# Je crée un tableau qui stocke tous mes fins d'URL pour chaque ville, sous format ./95/nom-ville
  return result = page_townhal.css('a[href*="95"]').map{|link| link["href"]}
end

# On crée une Méthode qui récupère l'adresse email d'un tableau de mairues à partir de l'URL d'une mairie
def get_the_email_of_a_townhal_from_its_webpage(result)
# On crée le hash

   result.each {|result|
   page_mairie = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com"+result)) 
 
# On récupère les adresses mail
   link = page_mairie.css('p:contains("@")').text

# On supprime le premier caractère qui est un espace  
   link[0]=""

# On récupère le nom de la commune  
   townhall = page_mairie.css('h1').text[11..-9]

# On crée le hash correspondant
   $data[townhall]=link

}

   return $data 

end

# On fait tourner nos deux méthodes. Le lien est créé grâce au $ de la variable result
def get_hash
get_the_email_of_a_townhal_from_its_webpage(get_all_the_urls_of_val_doise_townhalls)

end