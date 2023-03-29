---
title: Faire du web scraping avec python
date: 2023-03-20 00:00:00
categories: [web scraping, python, web]
tags: [web scraping, python, web, script]
---

Le **web scraping** est un procédé qui permet, à l'aide d'un langage de programmation et des langages adéquat, de récupérer les données présentes dans le code **html** d'une page web. 

Avec **Python** il est très facile de scrapper un site car de nombreuses bibliothèques existent, notamment : 
- Scrapy
- Selenium

Ces outils permettent de récupérer les données d'un site web, mais toutes n'ont pas le même procédé. Si Scrapy et Beautiful Soup permettent surtout de scraper le code HTML d'une page après qu'il ait été récupéré via une requête HTTP GET, Selenium permet de contrôler entièrement une navigateur via du code. Cela permet donc de coder des clics et de remplir des formulaires comme le ferait un utilisateur. 

## Utiliser Scrapy

Scrapy est un framework open source écrit en Python permettant de faire du web scraping. Il permet de récupérer des données de sites web en effectuant des requêtes HTTP et en analysant le code HTML de la réponse.

### Installation

Pour installer Scrapy, il suffit d'ouvrir un terminal et de taper la commande suivante : 

```bash
pip install scrapy
```

### Quelques fonctionnalités

- **Scrapy Shell** : permet de tester des sélecteurs CSS et XPath sur une page web

- **Scrapy Spiders** : permet de créer des scripts qui vont récupérer les données d'un site web

#### Scrapy Spiders

Un **Spider** est un script qui va récupérer les données d'un site web. Il est composé de 3 fonctions par convention :

- **start_requests()** : permet de définir les URLs à visiter

- **parse()** : permet de définir les sélecteurs CSS et XPath à utiliser pour récupérer les données

- **parse_item()** : permet de définir les sélecteurs CSS et XPath à utiliser pour récupérer les données

Dans ces différentes fonctions, on peut utiliser des sélecteurs CSS et XPath pour récupérer les données.

##### Sélecteurs CSS

Un sélecteur CSS permet de sélectionner un élément HTML à partir de son nom, de ses classes, de son identifiant, de ses attributs, de ses pseudos-classes ou de ses pseudos-éléments.

```Python
# Get the page html source
response = requests.get(url, headers=headers)
status_code = response.status_code

# If the status code of the response is 200, then the request was successful
if status_code == 200 :   

    # Get the html source
    source = response.text

    # If the source is not empty
    if source:

        # Create a selector
        selector = scrapy.Selector(text=source)

        # Get the h2 element with the id "noResult" 
        # ::text means that we want to get the text inside
        no_result = selector.css('h2#noResult::text').get()
        if no_result :
            return False

        # Get the ul with the class "crushed"
        ul = selector.css('ul.crushed')

        # Get all the li elements inside the ul
        li = ul.css('li')

        # get all h3 elements inside the li with the class "!tw-mb-0"
        h3 = li.css('h3.\!tw-mb-0')

        # get all the a elements inside the h3
        a = h3.css('a::text').getall()

        # get href attribute of the a elements inside the h3
        href = h3.css('a::attr(href)').getall()

        # Get all span with the attribute data-cy="publishDate"
        span = li.css('span[data-cy="publishDate"]')
```

#### Masquer son User-Agent

Lorsque l'on fait du web scraping, il est important de masquer son User-Agent pour éviter d'être bloqué par le site web. Pour cela, il suffit de créer un dictionnaire avec le User-Agent que l'on souhaite utiliser et de l'ajouter aux headers de la requête HTTP.

On peut utiliser un header simple : 

```Python
headers = {'User-Agent': ''}
```

Il est possible de récupérer le header depuis son propre navigateur en allant dans les paramètres de développement et en analysant le trafic **HTTP**.Parfois, certains sites sont particulièrement robustes. Il est donc nécessaire de concevoir un **headers** très élaboré.

Exemple avec le scraping du site de recherche d'emploi *Indeed* : 
```Python
headers = { 
        'Host': 'fr.indeed.com',
        "User-Agent": "",
        'Accept': '*/*', 
        'Accept-Language': 'fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3',
        'Accept-Encoding': 'gzip, deflate, br', 
        'Referer': "https://fr.indeed.com/companies?from=gnav-homepage",
        'Alt-Used': 'fr.indeed.com', 
        'Connection': 'keep-alive'      
    }
```

Cependant, les protections utilisées par certains sites régulièrement scrapés sont parfois robustes. Dans ce cas, il est nécessaire d'utiliser d'autres bibliothèques avec lesquelles il est plus simple de masquer ses actions. C'est le cas avec Selenium.

## Utiliser Selenium

Selenium est un outil open source qui permet de contrôler un navigateur web via du code. Il permet de simuler des actions comme le ferait un utilisateur : cliquer sur un bouton, remplir un formulaire, etc.

### Installation

Pour installer Selenium, il suffit d'ouvrir un terminal et de taper la commande suivante : 

```bash
pip install selenium
```

Cependant, il est également nécessaire d'installer un driver pour le navigateur que l'on souhaite contrôler. Pour cela, il suffit de se rendre sur le site de [Selenium](https://www.selenium.dev/documentation/en/webdriver/driver_requirements/) et de télécharger le driver correspondant au navigateur que l'on souhaite contrôler.

### Quelques fonctionnalités

Pour scraper un site web, il est nécessaire de créer un script qui va simuler les actions d'un utilisateur. Pour cela, il faut utiliser les méthodes suivantes :

- **get()** : permet de charger une page web
- **find_element_by_css_selector()** : permet de trouver un élément HTML à partir de son sélecteur CSS
- **find_elements_by_css_selector()** : permet de trouver plusieurs éléments HTML à partir de leur sélecteur CSS
- **click()** : permet de cliquer sur un élément HTML
- **send_keys()** : permet d'envoyer des données à un élément HTML

### Exemple de scraping avec Selenium

```Python
# Import the webdriver
from selenium import webdriver

url = "https://www.indeed.fr/emplois?q=python&l=Paris"

options = webdriver.ChromeOptions()
options.add_experimental_option('excludeSwitches', ['enable-logging'])
driver = webdriver.Chrome(options=options)

driver.get(url)
print(url)

# Wait for the page to load
driver.implicitly_wait(5)

# Get the job title and the url
elements = driver.find_elements(By.CSS_SELECTOR, "a.jcs-JobTitle")

for element in elements:
        
    job = {
        "id": element.get_attribute("id"),
        "url": element.get_attribute("href")
    }
```

## Conclusion

Dans cet article, nous avons vu comment scraper un site web en utilisant **Scrapy**. Nous avons également vu comment masquer son User-Agent et comment utiliser Selenium pour simuler les actions d'un utilisateur afin de masquer nos actions. 

#### Quelques liens utiles :
- [Web Scraping Guide: Headers & User-Agents Optimization Checklist](https://scrapeops.io/web-scraping-playbook/web-scraping-guide-header-user-agents/)
- [How to Scrape Indeed.com (2023 Update)](https://scrapfly.io/blog/how-to-scrape-indeedcom/)
- [Indeed jobs scraping with python, bs4, selenium, and pandas](https://www.pycodemates.com/2022/01/Indeed-jobs-scraping-with-python-bs4-selenium-and-pandas.html)
- [Python Scrapy: Build A Indeed Scraper [2023]](https://scrapeops.io/python-scrapy-playbook/python-scrapy-indeed-scraper/)
- [Web Scrape Indeed using Python](https://www.scrapingdog.com/blog/scrape-indeed-using-python/)
- [How To Solve 403 Forbidden Errors When Web Scraping](https://scrapeops.io/web-scraping-playbook/403-forbidden-error-web-scraping/)