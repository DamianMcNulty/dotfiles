SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `PropertyManagement` ;
USE `PropertyManagement` ;

-- -----------------------------------------------------
-- Table `PropertyManagement`.`Position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`Position` (
  `Position No.` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`Position No.`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PropertyManagement`.`Gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`Gender` (
  `Gender No.` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`Gender No.`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PropertyManagement`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`Staff` (
  `Staff No.` INT NOT NULL AUTO_INCREMENT,
  `fName` VARCHAR(45) NULL,
  `lName` VARCHAR(45) NULL,
  `position` INT NULL,
  `sex` INT NULL,
  `DOB` DATE NULL,
  PRIMARY KEY (`Staff No.`),
  INDEX `fk_Staff_Position1_idx` (`position` ASC),
  INDEX `fk_Staff_Gender1_idx` (`sex` ASC),
  CONSTRAINT `fk_Staff_Position1`
    FOREIGN KEY (`position`)
    REFERENCES `PropertyManagement`.`Position` (`Position No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_Gender1`
    FOREIGN KEY (`sex`)
    REFERENCES `PropertyManagement`.`Gender` (`Gender No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PropertyManagement`.`Owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`Owner` (
  `Owner No.` INT NOT NULL,
  `address` VARCHAR(45) NULL,
  `tel no.` VARCHAR(45) NULL,
  PRIMARY KEY (`Owner No.`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PropertyManagement`.`PropertyForRent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`PropertyForRent` (
  `Property No.` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `postcode` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `rooms` INT(11) NULL,
  `rent` DECIMAL NULL,
  `owner No` INT(11) NULL,
  `Staff No.` INT(11) NULL,
  PRIMARY KEY (`Property No.`),
  INDEX `fk_PropertyForRent_Owner_idx` (`owner No` ASC),
  INDEX `fk_PropertyForRent_Staff1_idx` (`Staff No.` ASC),
  CONSTRAINT `fk_PropertyForRent_Owner`
    FOREIGN KEY (`owner No`)
    REFERENCES `PropertyManagement`.`Owner` (`Owner No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PropertyForRent_Staff1`
    FOREIGN KEY (`Staff No.`)
    REFERENCES `PropertyManagement`.`Staff` (`Staff No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PropertyManagement`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`Client` (
  `Client No.` INT NOT NULL AUTO_INCREMENT,
  `fName` VARCHAR(45) NULL,
  `lName` VARCHAR(45) NULL,
  `tel no.` VARCHAR(45) NULL,
  `eMail` VARCHAR(45) NULL,
  `Staff No.` INT(11) NULL,
  PRIMARY KEY (`Client No.`),
  INDEX `fk_Client_Staff1_idx` (`Staff No.` ASC),
  CONSTRAINT `fk_Client_Staff1`
    FOREIGN KEY (`Staff No.`)
    REFERENCES `PropertyManagement`.`Staff` (`Staff No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PropertyManagement`.`Lease`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PropertyManagement`.`Lease` (
  `Lease No.` INT NOT NULL AUTO_INCREMENT,
  `paymentMethod` VARCHAR(45) NULL,
  `depositPaid` TINYINT(1) NULL,
  `rentStart` DATE NULL,
  `rentFinish` DATE NULL,
  `Property No.` INT(11) NULL,
  `Client No.` INT(11) NULL,
  PRIMARY KEY (`Lease No.`),
  INDEX `fk_Lease_Client1_idx` (`Client No.` ASC),
  INDEX `fk_Lease_PropertyForRent1_idx` (`Property No.` ASC),
  CONSTRAINT `fk_Lease_Client1`
    FOREIGN KEY (`Client No.`)
    REFERENCES `PropertyManagement`.`Client` (`Client No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lease_PropertyForRent1`
    FOREIGN KEY (`Property No.`)
    REFERENCES `PropertyManagement`.`PropertyForRent` (`Property No.`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
