-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('Client', 'Expert', 'Admin');

-- CreateEnum
CREATE TYPE "ContratType" AS ENUM ('ContratStandard', 'ContratVIP');

-- CreateEnum
CREATE TYPE "PaquetType" AS ENUM ('Gratuit', 'Standard', 'VIP');

-- CreateTable
CREATE TABLE "User" (
    "idUser" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "sexe" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "telephone" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "registerDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" "UserType" NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("idUser")
);

-- CreateTable
CREATE TABLE "Client" (
    "idClient" TEXT NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("idClient")
);

-- CreateTable
CREATE TABLE "Expert" (
    "idExpert" TEXT NOT NULL,

    CONSTRAINT "Expert_pkey" PRIMARY KEY ("idExpert")
);

-- CreateTable
CREATE TABLE "Admin" (
    "idAdmin" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("idAdmin")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "idUser" TEXT NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contrat" (
    "idContrat" TEXT NOT NULL,
    "typeContrat" TEXT NOT NULL,
    "dateSignature" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateFinContrat" TIMESTAMP(3) NOT NULL,
    "type" "ContratType" NOT NULL,

    CONSTRAINT "Contrat_pkey" PRIMARY KEY ("idContrat")
);

-- CreateTable
CREATE TABLE "ContratStandard" (
    "idContratStandard" TEXT NOT NULL,
    "idClient" TEXT NOT NULL,
    "idAdmin" TEXT NOT NULL,

    CONSTRAINT "ContratStandard_pkey" PRIMARY KEY ("idContratStandard")
);

-- CreateTable
CREATE TABLE "ContratVIP" (
    "idContratVIP" TEXT NOT NULL,
    "idClient" TEXT NOT NULL,
    "idAdmin" TEXT NOT NULL,
    "idExpert" TEXT NOT NULL,

    CONSTRAINT "ContratVIP_pkey" PRIMARY KEY ("idContratVIP")
);

-- CreateTable
CREATE TABLE "Abonnement" (
    "idAbonnement" TEXT NOT NULL,

    CONSTRAINT "Abonnement_pkey" PRIMARY KEY ("idAbonnement")
);

-- CreateTable
CREATE TABLE "Paquet" (
    "idPaquet" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "type" "PaquetType" NOT NULL,
    "idAbonnement" TEXT NOT NULL,

    CONSTRAINT "Paquet_pkey" PRIMARY KEY ("idPaquet")
);

-- CreateTable
CREATE TABLE "Chat" (
    "idChat" TEXT NOT NULL,
    "dateDebut" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "idClient" TEXT NOT NULL,

    CONSTRAINT "Chat_pkey" PRIMARY KEY ("idChat")
);

-- CreateTable
CREATE TABLE "Conversation" (
    "idConversation" TEXT NOT NULL,
    "dateDebut" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateFin" TIMESTAMP(3) NOT NULL,
    "tag" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "idChat" TEXT NOT NULL,

    CONSTRAINT "Conversation_pkey" PRIMARY KEY ("idConversation")
);

-- CreateTable
CREATE TABLE "Message" (
    "idMessage" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "dateEnvoi" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "idConversation" TEXT NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("idMessage")
);

-- CreateTable
CREATE TABLE "Ticket" (
    "idTicket" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "numero" SERIAL NOT NULL,
    "priorite" TEXT NOT NULL,
    "tags" TEXT NOT NULL,
    "typeTicket" TEXT NOT NULL,
    "statut" TEXT NOT NULL,
    "idExpert" TEXT NOT NULL,

    CONSTRAINT "Ticket_pkey" PRIMARY KEY ("idTicket")
);

-- CreateTable
CREATE TABLE "Notification" (
    "idNotif" TEXT NOT NULL,
    "notif" TEXT NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("idNotif")
);

-- CreateTable
CREATE TABLE "Msg" (
    "idMsg" TEXT NOT NULL,
    "idClient" TEXT NOT NULL,

    CONSTRAINT "Msg_pkey" PRIMARY KEY ("idMsg")
);

-- CreateTable
CREATE TABLE "Formation" (
    "idFormation" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "duree" INTEGER NOT NULL,
    "idClient" TEXT NOT NULL,
    "idTicket" TEXT NOT NULL,

    CONSTRAINT "Formation_pkey" PRIMARY KEY ("idFormation")
);

-- CreateTable
CREATE TABLE "Workshop" (
    "idWorkshop" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "duree" INTEGER NOT NULL,
    "idClient" TEXT NOT NULL,
    "idTicket" TEXT NOT NULL,

    CONSTRAINT "Workshop_pkey" PRIMARY KEY ("idWorkshop")
);

-- CreateTable
CREATE TABLE "Rapport" (
    "idRapport" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "idWorkshop" TEXT NOT NULL,
    "idFormation" TEXT NOT NULL,

    CONSTRAINT "Rapport_pkey" PRIMARY KEY ("idRapport")
);

-- CreateTable
CREATE TABLE "Gratuit" (
    "idGratuit" TEXT NOT NULL,

    CONSTRAINT "Gratuit_pkey" PRIMARY KEY ("idGratuit")
);

-- CreateTable
CREATE TABLE "Standard" (
    "idStandard" TEXT NOT NULL,

    CONSTRAINT "Standard_pkey" PRIMARY KEY ("idStandard")
);

-- CreateTable
CREATE TABLE "VIP" (
    "idVIP" TEXT NOT NULL,

    CONSTRAINT "VIP_pkey" PRIMARY KEY ("idVIP")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_firstname_key" ON "User"("firstname");

-- CreateIndex
CREATE UNIQUE INDEX "User_lastname_key" ON "User"("lastname");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_idUser_key" ON "Profile"("idUser");

-- CreateIndex
CREATE UNIQUE INDEX "ContratStandard_idClient_key" ON "ContratStandard"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "ContratStandard_idAdmin_key" ON "ContratStandard"("idAdmin");

-- CreateIndex
CREATE UNIQUE INDEX "ContratVIP_idClient_key" ON "ContratVIP"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "ContratVIP_idAdmin_key" ON "ContratVIP"("idAdmin");

-- CreateIndex
CREATE UNIQUE INDEX "ContratVIP_idExpert_key" ON "ContratVIP"("idExpert");

-- CreateIndex
CREATE UNIQUE INDEX "Paquet_idAbonnement_key" ON "Paquet"("idAbonnement");

-- CreateIndex
CREATE UNIQUE INDEX "Chat_idClient_key" ON "Chat"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "Conversation_idChat_key" ON "Conversation"("idChat");

-- CreateIndex
CREATE UNIQUE INDEX "Ticket_idExpert_key" ON "Ticket"("idExpert");

-- CreateIndex
CREATE UNIQUE INDEX "Msg_idClient_key" ON "Msg"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "Formation_idClient_key" ON "Formation"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "Formation_idTicket_key" ON "Formation"("idTicket");

-- CreateIndex
CREATE UNIQUE INDEX "Workshop_idClient_key" ON "Workshop"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "Workshop_idTicket_key" ON "Workshop"("idTicket");

-- CreateIndex
CREATE UNIQUE INDEX "Rapport_idWorkshop_key" ON "Rapport"("idWorkshop");

-- CreateIndex
CREATE UNIQUE INDEX "Rapport_idFormation_key" ON "Rapport"("idFormation");

-- AddForeignKey
ALTER TABLE "Client" ADD CONSTRAINT "Client_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "User"("idUser") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Expert" ADD CONSTRAINT "Expert_idExpert_fkey" FOREIGN KEY ("idExpert") REFERENCES "User"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_idAdmin_fkey" FOREIGN KEY ("idAdmin") REFERENCES "User"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "User"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratStandard" ADD CONSTRAINT "ContratStandard_idContratStandard_fkey" FOREIGN KEY ("idContratStandard") REFERENCES "Contrat"("idContrat") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratStandard" ADD CONSTRAINT "ContratStandard_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratStandard" ADD CONSTRAINT "ContratStandard_idAdmin_fkey" FOREIGN KEY ("idAdmin") REFERENCES "Admin"("idAdmin") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratVIP" ADD CONSTRAINT "ContratVIP_idContratVIP_fkey" FOREIGN KEY ("idContratVIP") REFERENCES "Contrat"("idContrat") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratVIP" ADD CONSTRAINT "ContratVIP_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratVIP" ADD CONSTRAINT "ContratVIP_idAdmin_fkey" FOREIGN KEY ("idAdmin") REFERENCES "Admin"("idAdmin") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContratVIP" ADD CONSTRAINT "ContratVIP_idExpert_fkey" FOREIGN KEY ("idExpert") REFERENCES "Expert"("idExpert") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Paquet" ADD CONSTRAINT "Paquet_idAbonnement_fkey" FOREIGN KEY ("idAbonnement") REFERENCES "Abonnement"("idAbonnement") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat" ADD CONSTRAINT "Chat_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conversation" ADD CONSTRAINT "Conversation_idChat_fkey" FOREIGN KEY ("idChat") REFERENCES "Chat"("idChat") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_idConversation_fkey" FOREIGN KEY ("idConversation") REFERENCES "Conversation"("idConversation") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_idExpert_fkey" FOREIGN KEY ("idExpert") REFERENCES "Expert"("idExpert") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Msg" ADD CONSTRAINT "Msg_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Formation" ADD CONSTRAINT "Formation_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Formation" ADD CONSTRAINT "Formation_idTicket_fkey" FOREIGN KEY ("idTicket") REFERENCES "Ticket"("idTicket") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Workshop" ADD CONSTRAINT "Workshop_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Workshop" ADD CONSTRAINT "Workshop_idTicket_fkey" FOREIGN KEY ("idTicket") REFERENCES "Ticket"("idTicket") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapport" ADD CONSTRAINT "Rapport_idWorkshop_fkey" FOREIGN KEY ("idWorkshop") REFERENCES "Workshop"("idWorkshop") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapport" ADD CONSTRAINT "Rapport_idFormation_fkey" FOREIGN KEY ("idFormation") REFERENCES "Formation"("idFormation") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gratuit" ADD CONSTRAINT "Gratuit_idGratuit_fkey" FOREIGN KEY ("idGratuit") REFERENCES "Paquet"("idPaquet") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Standard" ADD CONSTRAINT "Standard_idStandard_fkey" FOREIGN KEY ("idStandard") REFERENCES "Paquet"("idPaquet") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VIP" ADD CONSTRAINT "VIP_idVIP_fkey" FOREIGN KEY ("idVIP") REFERENCES "Paquet"("idPaquet") ON DELETE RESTRICT ON UPDATE CASCADE;
