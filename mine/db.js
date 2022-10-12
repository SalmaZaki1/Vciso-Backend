/*{// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
    provider = "prisma-client-js"
  }
  
  datasource db {
    provider = "postgresql"
    url      = env("DATABASE_URL")
  }
  
  enum UserType {
    Client
    Expert
    Admin
  }
  
  model User {
    idUser      String   @id @default(cuid())
    username     String  @unique
    password     String 
    firstname    String    
    lastname     String    
    sexe         String
    age          Int
    telephone    String
    city         String
    email        String    @unique
    registerDate DateTime? @default(now())
    type UserType
  
    client  Client?
    expert Expert?
    admin Admin?
    profile Profile?
  }
  
  model Client {
    user User @relation(fields:[idClient], references: [idUser],onDelete: Cascade)
    idClient      String   @id @default(cuid())
    
   
    chat   Chat?
    message Msg?
    formation Formation?
    workshop Workshop?
    contratStandard ContratStandard? 
    contratVIP  ContratVIP?
  }
  
  model  Expert {
    user User @relation(fields:[idExpert], references: [idUser])
    idExpert      String   @id @default(cuid())
    
    contratVIP  ContratVIP?
    ticket Ticket[]
  }
  
  model Admin {
    user User @relation(fields:[idAdmin], references: [idUser])
    idAdmin      String   @id @default(cuid())
  
    contratStandard  ContratStandard?
    contratVIP ContratVIP?
  }
  
  model Profile {
    id     Int  @id @default(autoincrement())
    user   User @relation(fields: [idUser], references: [idUser])
    idUser String  @unique // relation scalar field (used in the `@relation` attribute above)
  }
  enum ContratType {
    ContratStandard 
    ContratVIP
  }
  
  model Contrat {
    idContrat String @id @default(cuid())
    typeContrat String
    dateSignature DateTime @default(now())
    dateFinContrat DateTime 
    type ContratType
    
    contratStandard  ContratStandard?
    contratVIP ContratVIP?
  }
  
  model ContratStandard {
    contrat Contrat @relation(fields:[idContratStandard],references:[idContrat],onDelete:Cascade)
    idContratStandard String @id @default(cuid())
    
    client Client @relation(fields:[idClient],references:[idClient])
    idClient String @unique
    admin Admin @relation(fields:[idAdmin],references:[idAdmin])
    idAdmin String @unique
  }
  
  model ContratVIP {
    contrat Contrat @relation(fields: [idContratVIP],references:[idContrat],onDelete:Cascade)
    idContratVIP String @id @default(cuid())
  
    client Client @relation(fields:[idClient],references:[idClient])
    idClient String @unique
    admin Admin @relation(fields:[idAdmin],references:[idAdmin])
    idAdmin String @unique
    expert Expert @relation(fields:[idExpert],references:[idExpert])
    idExpert String @unique
  }
  
  model Abonnement {
    idAbonnement String @id @default(cuid())
    paquet Paquet?
  }
  
  enum PaquetType {
    Gratuit
    Standard
    VIP
  }
  
  model Paquet {
    idPaquet String @id @default(cuid())
    name String
    price Float
    
    type PaquetType
  
    gratuit Gratuit?
    standard Standard?
    vip VIP?
    abonnement Abonnement @relation(fields: [idAbonnement], references: [idAbonnement])
    idAbonnement String @unique
  }
  
  model Chat {
    idChat String @id @default(cuid())
    dateDebut DateTime @default(now())
    client   Client @relation(fields: [idClient], references: [idClient])
    idClient  String  @unique 
    conversation Conversation[]
  }
  
  model Conversation {
    idConversation String @id @default(cuid())
    dateDebut DateTime @default(now())
    dateFin DateTime 
    tag String
    status String
    messages Message[]
    idChat String @unique
    chat Chat @relation(fields: [idChat], references: [idChat])
  }
  
  model Message {
    idMessage String @id @default(cuid())
    message String
    dateEnvoi DateTime @default(now())
    idConversation String
    conversation Conversation @relation(fields: [idConversation], references: [idConversation])
  }
   
  
  model Ticket {
    idTicket String @id @default(cuid())
    description String
    numero Int @default(autoincrement())
    priorite String
    tags String 
    typeTicket String
    statut String
    expert Expert @relation(fields:[idExpert], references: [idExpert])
    idExpert String @unique
    formation Formation[]
    workshop  Workshop[]
  
  }
  
  model Notification {
    idNotif String @id @default(cuid())  
    notif String 
  }
  
  
  model Msg {
    idMsg String @id @default(cuid())
  
    client Client @relation(fields:[idClient],references:[idClient])
    idClient String @unique
  } 
  
  model Formation {
    idFormation String @id @default(cuid())
    name String
    duree Int
    rapport Rapport?
    client Client @relation(fields:[idClient],references:[idClient])
    idClient String @unique
    ticket Ticket @relation(fields:[idTicket],references:[idTicket])
    idTicket String @unique
  }
  
  model Workshop {
    idWorkshop String @id @default(cuid())
    name String
    duree Int
    rapport Rapport?
    client Client @relation(fields:[idClient],references:[idClient])
    idClient String @unique
    ticket Ticket @relation(fields:[idTicket],references:[idTicket])
    idTicket String @unique
  }
  
  model Rapport {
    idRapport String @id @default(cuid())
    description String
    idWorkshop String @unique
    workshop Workshop  @relation(fields: [idWorkshop], references: [idWorkshop])
    idFormation String @unique
    formation Formation @relation(fields: [idFormation], references: [idFormation])
  }
  
  model Gratuit {
    paquet Paquet @relation(fields: [idGratuit], references: [idPaquet])
    idGratuit String @id @default(cuid())
  }
  model Standard {
    paquet Paquet @relation(fields: [idStandard], references: [idPaquet])
    idStandard String @id @default(cuid())
  }
  model VIP {
    paquet Paquet @relation(fields: [idVIP], references: [idPaquet])
    idVIP String @id @default(cuid())
  }
  */