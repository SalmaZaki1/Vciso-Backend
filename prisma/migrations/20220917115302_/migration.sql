/*
  Warnings:

  - You are about to drop the column `idClient` on the `Chat` table. All the data in the column will be lost.
  - You are about to drop the column `dateEnvoi` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `idConversation` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `idClient` on the `Msg` table. All the data in the column will be lost.
  - You are about to drop the `Conversation` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[idChat]` on the table `Message` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `idChat` to the `Message` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senderId` to the `Message` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_idClient_fkey";

-- DropForeignKey
ALTER TABLE "Conversation" DROP CONSTRAINT "Conversation_idChat_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_idConversation_fkey";

-- DropForeignKey
ALTER TABLE "Msg" DROP CONSTRAINT "Msg_idClient_fkey";

-- DropIndex
DROP INDEX "Chat_idClient_key";

-- DropIndex
DROP INDEX "Msg_idClient_key";

-- AlterTable
ALTER TABLE "Chat" DROP COLUMN "idClient",
ADD COLUMN     "members" TEXT[];

-- AlterTable
ALTER TABLE "Message" DROP COLUMN "dateEnvoi",
DROP COLUMN "idConversation",
ADD COLUMN     "idChat" TEXT NOT NULL,
ADD COLUMN     "senderId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Msg" DROP COLUMN "idClient";

-- DropTable
DROP TABLE "Conversation";

-- CreateIndex
CREATE UNIQUE INDEX "Message_idChat_key" ON "Message"("idChat");

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_idChat_fkey" FOREIGN KEY ("idChat") REFERENCES "Chat"("idChat") ON DELETE RESTRICT ON UPDATE CASCADE;
