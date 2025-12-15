-- CreateTable
CREATE TABLE "users" (
    "idUser" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "image" TEXT,
    "description" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "followers" (
    "idFollower" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "followerId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "followers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "followers_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "authors" (
    "idAuthor" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "biography" TEXT,
    "image" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "genres" (
    "idGender" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "books" (
    "idBook" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "synopsis" TEXT NOT NULL,
    "publisher" TEXT NOT NULL,
    "launchYear" INTEGER NOT NULL,
    "pages" INTEGER NOT NULL,
    "isbn" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "books_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "authors" ("idAuthor") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "book_genres" (
    "idBookGender" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bookId" INTEGER NOT NULL,
    "genderId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "book_genres_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "books" ("idBook") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "book_genres_genderId_fkey" FOREIGN KEY ("genderId") REFERENCES "genres" ("idGender") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "bookshelves" (
    "idBookshelf" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "rating" INTEGER DEFAULT 0,
    "startDate" DATETIME,
    "endDate" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "bookshelves_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "bookshelves_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "books" ("idBook") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "reading_histories" (
    "idReadingHistory" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bookshelfId" INTEGER NOT NULL,
    "pagesRead" INTEGER NOT NULL,
    "comment" TEXT,
    "emoji" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "reading_histories_bookshelfId_fkey" FOREIGN KEY ("bookshelfId") REFERENCES "bookshelves" ("idBookshelf") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "quotes" (
    "idQuote" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "page" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "quotes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "quotes_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "books" ("idBook") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "reviews" (
    "idReview" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "reviews_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "reviews_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "books" ("idBook") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "offensives" (
    "idOffensive" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "consecutiveDays" INTEGER NOT NULL DEFAULT 0,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "offensives_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "annual_statistics" (
    "idAnnualStatistics" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "booksRead" INTEGER NOT NULL DEFAULT 0,
    "pagesRead" INTEGER NOT NULL DEFAULT 0,
    "daysRead" INTEGER NOT NULL DEFAULT 0,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "annual_statistics_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("idUser") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "author_statistics" (
    "idAuthorStatistics" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "annualStatisticsId" INTEGER NOT NULL,
    "authorId" INTEGER NOT NULL,
    "booksRead" INTEGER NOT NULL DEFAULT 0,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "author_statistics_annualStatisticsId_fkey" FOREIGN KEY ("annualStatisticsId") REFERENCES "annual_statistics" ("idAnnualStatistics") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "author_statistics_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "authors" ("idAuthor") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "gender_statistics" (
    "idGenderStatistics" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "annualStatisticsId" INTEGER NOT NULL,
    "genderId" INTEGER NOT NULL,
    "booksRead" INTEGER NOT NULL DEFAULT 0,
    "pagesRead" INTEGER NOT NULL DEFAULT 0,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "gender_statistics_annualStatisticsId_fkey" FOREIGN KEY ("annualStatisticsId") REFERENCES "annual_statistics" ("idAnnualStatistics") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "gender_statistics_genderId_fkey" FOREIGN KEY ("genderId") REFERENCES "genres" ("idGender") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "followers_userId_followerId_key" ON "followers"("userId", "followerId");

-- CreateIndex
CREATE UNIQUE INDEX "genres_name_key" ON "genres"("name");

-- CreateIndex
CREATE UNIQUE INDEX "books_isbn_key" ON "books"("isbn");

-- CreateIndex
CREATE UNIQUE INDEX "book_genres_bookId_genderId_key" ON "book_genres"("bookId", "genderId");

-- CreateIndex
CREATE UNIQUE INDEX "bookshelves_userId_bookId_key" ON "bookshelves"("userId", "bookId");

-- CreateIndex
CREATE UNIQUE INDEX "reviews_userId_bookId_key" ON "reviews"("userId", "bookId");

-- CreateIndex
CREATE UNIQUE INDEX "offensives_userId_key" ON "offensives"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "annual_statistics_userId_year_key" ON "annual_statistics"("userId", "year");

-- CreateIndex
CREATE UNIQUE INDEX "author_statistics_annualStatisticsId_authorId_key" ON "author_statistics"("annualStatisticsId", "authorId");

-- CreateIndex
CREATE UNIQUE INDEX "gender_statistics_annualStatisticsId_genderId_key" ON "gender_statistics"("annualStatisticsId", "genderId");
