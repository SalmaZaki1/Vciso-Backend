/*
  Warnings:

  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "User_firstname_key";

-- DropIndex
DROP INDEX "User_lastname_key";

-- AlterTable
ALTER TABLE "Msg" ADD COLUMN     "members" TEXT[],
ADD COLUMN     "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "registerDate" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");
