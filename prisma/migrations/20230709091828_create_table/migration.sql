-- CreateTable
CREATE TABLE `roles` (
    `ID` VARCHAR(191) NOT NULL,
    `Name` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `ID` VARCHAR(191) NOT NULL,
    `Email` VARCHAR(100) NOT NULL,
    `Username` VARCHAR(100) NOT NULL,
    `Password` VARCHAR(100) NOT NULL,
    `RoleId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `users_Email_key`(`Email`),
    UNIQUE INDEX `users_Username_key`(`Username`),
    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_details` (
    `ID` VARCHAR(191) NOT NULL,
    `Name` VARCHAR(100) NOT NULL,
    `Phone` VARCHAR(15) NOT NULL,
    `ProfilePhoto` VARCHAR(255) NOT NULL,
    `UserID` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `user_details_UserID_key`(`UserID`),
    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `addresses` (
    `ID` VARCHAR(191) NOT NULL,
    `Recipient` VARCHAR(100) NOT NULL,
    `Phone` VARCHAR(15) NOT NULL,
    `CityId` INTEGER NOT NULL,
    `CityName` VARCHAR(100) NOT NULL,
    `ProvinceId` INTEGER NOT NULL,
    `ProvinceName` VARCHAR(100) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    `Note` VARCHAR(255) NOT NULL,
    `Mark` VARCHAR(10) NOT NULL,
    `IsPrimary` BOOLEAN NOT NULL DEFAULT false,
    `UserId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `voucher_types` (
    `ID` VARCHAR(191) NOT NULL,
    `Type` VARCHAR(100) NOT NULL,
    `PhotoUrl` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vouchers` (
    `ID` VARCHAR(191) NOT NULL,
    `StartDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `EndDate` DATETIME NOT NULL,
    `MinimumPurchase` DOUBLE NULL,
    `MaximumDiscount` DOUBLE NULL,
    `DiscountPercent` DOUBLE NOT NULL DEFAULT 100.00,
    `ClaimedUserCount` INTEGER NOT NULL,
    `MaxClaimLimit` INTEGER NOT NULL,
    `VoucherTypeId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `informations` (
    `ID` VARCHAR(191) NOT NULL,
    `Title` VARCHAR(65) NOT NULL,
    `Status` VARCHAR(10) NOT NULL,
    `PhotoContent` VARCHAR(255) NOT NULL,
    `Content` LONGTEXT NOT NULL,
    `ViewCount` INTEGER NOT NULL,
    `BookmarkCount` INTEGER NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_categories` (
    `ID` VARCHAR(191) NOT NULL,
    `Category` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `ID` VARCHAR(191) NOT NULL,
    `Name` VARCHAR(100) NOT NULL,
    `Stock` INTEGER NOT NULL,
    `Status` VARCHAR(10) NOT NULL,
    `Price` DOUBLE NOT NULL,
    `Ratting` DOUBLE NOT NULL,
    `Description` LONGTEXT NOT NULL,
    `ProductCategoryId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_images` (
    `ID` VARCHAR(191) NOT NULL,
    `ProductImage` VARCHAR(255) NOT NULL,
    `ProductId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transactions` (
    `ID` VARCHAR(191) NOT NULL,
    `StatusTransaction` VARCHAR(100) NOT NULL,
    `ReceiptNumber` VARCHAR(100) NOT NULL,
    `TransactionId` VARCHAR(100) NOT NULL,
    `OrderId` VARCHAR(100) NOT NULL,
    `TotalProductPrice` DOUBLE NOT NULL,
    `TotalShippingPrice` DOUBLE NOT NULL,
    `PaymentMethod` VARCHAR(100) NOT NULL,
    `PaymentStatus` VARCHAR(100) NOT NULL,
    `ExpeditionName` VARCHAR(100) NOT NULL,
    `ExpeditionStatus` VARCHAR(100) NOT NULL,
    `CancellationReason` LONGTEXT NULL,
    `ExpeditionRating` DOUBLE NULL,
    `Discount` DOUBLE NULL,
    `TotalPrice` DOUBLE NOT NULL,
    `UserId` VARCHAR(191) NOT NULL,
    `VoucherId` VARCHAR(191) NOT NULL,
    `AddressId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transaction_details` (
    `ID` VARCHAR(191) NOT NULL,
    `Qty` INTEGER NOT NULL,
    `SubTotalPrice` DOUBLE NOT NULL,
    `TransactionId` VARCHAR(191) NOT NULL,
    `ProductId` VARCHAR(191) NOT NULL,
    `RatingProductId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `transaction_details_RatingProductId_key`(`RatingProductId`),
    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rating_products` (
    `ID` VARCHAR(191) NOT NULL,
    `Rating` DOUBLE NOT NULL,
    `Comment` LONGTEXT NOT NULL,
    `CommentAdmin` LONGTEXT NOT NULL,
    `Photo` VARCHAR(255) NOT NULL,
    `Video` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_RoleId_fkey` FOREIGN KEY (`RoleId`) REFERENCES `roles`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_details` ADD CONSTRAINT `user_details_UserID_fkey` FOREIGN KEY (`UserID`) REFERENCES `users`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `addresses` ADD CONSTRAINT `addresses_UserId_fkey` FOREIGN KEY (`UserId`) REFERENCES `users`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vouchers` ADD CONSTRAINT `vouchers_VoucherTypeId_fkey` FOREIGN KEY (`VoucherTypeId`) REFERENCES `voucher_types`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `products` ADD CONSTRAINT `products_ProductCategoryId_fkey` FOREIGN KEY (`ProductCategoryId`) REFERENCES `product_categories`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_images` ADD CONSTRAINT `product_images_ProductId_fkey` FOREIGN KEY (`ProductId`) REFERENCES `products`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_UserId_fkey` FOREIGN KEY (`UserId`) REFERENCES `users`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_VoucherId_fkey` FOREIGN KEY (`VoucherId`) REFERENCES `vouchers`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_AddressId_fkey` FOREIGN KEY (`AddressId`) REFERENCES `addresses`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaction_details` ADD CONSTRAINT `transaction_details_TransactionId_fkey` FOREIGN KEY (`TransactionId`) REFERENCES `transactions`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaction_details` ADD CONSTRAINT `transaction_details_ProductId_fkey` FOREIGN KEY (`ProductId`) REFERENCES `products`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaction_details` ADD CONSTRAINT `transaction_details_RatingProductId_fkey` FOREIGN KEY (`RatingProductId`) REFERENCES `rating_products`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
