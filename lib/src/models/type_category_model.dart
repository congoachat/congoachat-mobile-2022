import 'dart:convert';

class TypeCategoryModel{

  String title;
  TypeCategoryModel({this.title});

  void setTitle(String getTitle){
    title = getTitle;
  }

  String getTitle(){
    return title;
  }
  static Map<String, dynamic> stringToMap(String s) {
    Map<String, dynamic> map = json.decode(s);
    return map;
  }


  }


List<TypeCategoryModel> getAutomobiles(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VEHICULES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VEHICULES PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BUS');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BUS PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MOTO');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MOTO PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VELO');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VELO PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CAMION');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CAMION PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('REMORQUE');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('REMORQUE PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BATEAU');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BATEAU PIECES ET ACCESSOIRES');
  category.add(categoryModel);

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}


List<TypeCategoryModel> getPropriete(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MAISONS ET APPARTEMENTS A LOUER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MAISONS ET APPARTEMENTS A VENDRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PROPRIETE COMMERCIALE A LOUER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PROPRIETE COMMERCIALE A VENDRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TERRAINS ET PARCELLES A LOUER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TERRAINS ET PARCELLES A VENDRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('HOTELS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}


List<TypeCategoryModel> getShop(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MEUBLES DE MAISON');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MEUBLES DE BUREAU');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('GALERIE D’ART');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('QUINCAILLERIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PAPETERIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POMPE FUNEBRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DISCOTHEQUES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('RESTAURANTS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PHARMACIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getMan(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUSSURES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SANDALES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHEMISES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POLO');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JACKET');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SOUS-VETEMENTS ET INTIMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COSTUMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAPEAU ET CASQUETTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PENTALONS ET JEANS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CULOTTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ENSEMBLE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUSSETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MAILLOTS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CEINTURES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CRAVATES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SAC ET VALISE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MONTRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LUNETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BIJOUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PARFUMS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('UNIFORMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MARIAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getWoman(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ROBES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JUPES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUSSURES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SANDALES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHEMISES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POLO');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JACKETS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SOUS-VETEMENTS ET INTIMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COSTUMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAPEAU ET CASQUETTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PENTALONS ET JEANS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CULOTTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUSETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MAILLOT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CEINTURES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CRAVATES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SAC ET VALISE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MONTRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LUNETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BIJOUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PARFUMS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('UNIFORMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MARIAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MATERNITE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}


List<TypeCategoryModel> getBaby(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BIBERONS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BERCEAU');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POUSETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ROBES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JUPES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUSSURES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SANDALES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHEMISES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POLO');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JACKETS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SOUS-VETEMENTS ET INTIMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COSTUMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COSTUMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAPEAUX ET CASQUETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PENTALONS ET JEANS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CULOTTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ENSEMBLES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUSETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MAILLOTS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CEINTURES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CRAVATES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SAC ET VALISES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MONTRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LUNETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BIJOUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PARFUMS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('UNIFORMES');
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MATERNITE');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getElectronic(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TELEPHONES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TELEPHONES PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TABLETTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TABLETTES PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ORDINATEURS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ORDINATEURS PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TELEVISIONS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TELEVISIONS PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CAMERAS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CAMERAS PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NAVIGATIONS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NAVIGATIONS PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('IMPRIMANTES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('IMPRIMANTES PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SCANNERS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SCANNERS PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MUSIQUES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MUSIQUES PIECES ET ACCESSOIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SECURITE ET SURVEILLANCE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MP3 ET MP4');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BAFFLES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DVD PLAYER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getGames(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JEUX POUR HOMME');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JEUX POUR FEMME');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JEUX POUR BEBE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JEUX DE SOCIETE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('JEUX POUR ANIMAUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getSports(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('FOOTBALL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BASKET BALL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VOLEY BALL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('HAND BALL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TENNIS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NETBALL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('GOLF');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NATATION');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BOXE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('KARATE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BOLLING');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BILLIARD');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getBooks(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ECOLE GARDIENNE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ECOLE PRIMAIRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SCIENTIFIQUE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MATHEMATIQUE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('FRANÇAIS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ANGLAIS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LATIN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PHYSIQUE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BIOLOGIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHIMIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('HISTOIRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('GEOGRAPHIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PEDAGOGIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LITTÉRATURE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ECONOMIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COMMERCE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LOI & GUERRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BANDE DESSINEE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DOCTEUR & VETERINAIRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AGRICULTURE ET AGRONOMIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SANTE & PHARMACIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ARCHITECTURE & VOYAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('INGENIEUR & CONSTRUCTION');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MARKETING & MANAGEMENT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POLITIQUE ET CRIMINOLOGIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('R.HUMAINES & ENVIRONEMENT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PHOTOGRAPHIE & CAMERAMAN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ARGENT & AFFAIRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TECHNOLOGIE & I.T');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NOURRITURE & CUISINE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VINS & ALCOOLS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SPORTS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('FICTION & MYSTERE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('RELIGION & SPIRITUEL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SPORT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('FICTION & MISTERY');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('RELIGION & SPIRITUAL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AMOUR & ROMANCE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MUSIQUE & POEME');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COMEDIE & JOURNALISME');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ENTREPRENEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PROVERBES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getJobApplication(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('STAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COMPTABLE & FINANCIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MARKETEUR & MANAGEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ENTREPRENEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ARTISTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SERVEUR & HOTESSE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BANQUIER & ASSUREUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MENAGERE & NETTOYEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('INFORMATICIEN & PROGRAMMEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('INGENIEUR & ARCHITECTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('MAÇON & CHARPENTIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SERVICE CLIENT & GARDIENAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COIFFEUR & SOINS CORPOREL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DOCTEUR & VETERINAIRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AVOCAT & JURISTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LOGISTICIEN & TRANSPORTEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('USINE & INDUSTRIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BUREAU & ADMINISTRATION');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHAUFFEUR & MECANICIEN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PROFESSEUR & JOURNALISTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DANSEUR & D.J');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHANTEUR & PECHEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ACTEUR & PRODUCTEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('EVENEMENTIEL & DECORATEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PHOTOGRAPHE & CAMERAMAN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('RESSOURCES HUMAINES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AVIATION & AGENT DE BORD');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AGENT IMMOBILIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TECHNICIEN & ELECTRONICIEN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COMEDIEN & THEATRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SOUDEUR & PLOMBIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('TAILLEUR & CORDONIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('GOUVERNEMENT & POLITIQUE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AGRICULTEUR & O.N.G');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getJobOffer(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V STAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V COMPTABILITE & FINANCE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V MARKETING & PROMOTION');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V ART & ENTREPRENARIAT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V RESTAURANT & HOTEL');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V BANQUE & ASSURANCE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V MENAGE & NETTOYAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V TECHNOLOGIE & I.T');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V INGENIEUR & ARCHITECTURE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V CONSTRUCTION ');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V CENTRE D’APPEL & SECURITE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V COIFFURE & BEAUTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V DOCTEUR & VETERINAIRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V LOI & LEGALE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V LOGISTIQUE & TRANSPORT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V USINE & INDUSTRIE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V BUREAU & ADMINISTRATION');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V CHAUFFEUR & MECANICIEN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V  TAILLEUR & CHARPENTIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V PROFESSEUR & JOURNALISTE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V DANSEUR & D.J');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V CHANTEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V PECHEUR ET CHASSEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V ACTEUR & PRODUCTEUR');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V EVENEMENT & DECORATION');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V PHOTOGRAPHIE & CAMERAMAN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V RESSOURCES HUMAINES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V AVIATION & AGENT DE BORD');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V AGENT IMMOBILIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V TECHNICIEN & ELECTRONICIEN');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V  COMEDIEN & THEATRE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V SOUDEUR & PLOMBIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V TAILLEUR & CORDONIER');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V GOUVERNEMENT & POLITIQUE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V AGRICULTURE ET ELEVAGE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('C.V O.N.G');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}

List<TypeCategoryModel> getFoods(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NOURRITURES POUR BEBE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NOURRITURES DE SPORTS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('NOURRITURES POUR ANIMAUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('FRUITS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LEGUMES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VIANDE & POISSONS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('GRAINES ET ENGRAIS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('A GRINIOTER ET AMUSE-GUELLE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BOISSON NON-ALCOOLISEE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('BOISSON ALCOOLISEE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PLATS OU MENU RESTAURANT');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}
List<TypeCategoryModel> getCommunity(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('OBJET PERDU ET RETROUVE');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('ECHANGEONS NOS OBJETS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DON DE CHARITÉ');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('EVENEMENTS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}


List<TypeCategoryModel> getAnimals(){
  List<TypeCategoryModel> category = new List<TypeCategoryModel>();
  TypeCategoryModel categoryModel = new TypeCategoryModel();

  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHIENS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHATS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POULES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CANARDS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('DINDES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHEVRES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('CHEVAUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('VACHES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('COCHONS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('LAPINS ET RATS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('SERPENTS & REPTILES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('POISSONS ET AQUATIQUES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('GRENOUILLES & AMPHIBIENS');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('PIGEONS & OISEAUX');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('INSECTS & SAUTERELLES');
  category.add(categoryModel);
  categoryModel = new TypeCategoryModel();
  categoryModel.setTitle('AUTRES');
  category.add(categoryModel);

  return category;
}




