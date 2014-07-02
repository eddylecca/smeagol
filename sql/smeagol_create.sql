-- MySQL Script generated by MySQL Workbench
-- 07/02/14 01:25:13
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema smeagol
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smeagol` DEFAULT CHARACTER SET utf8 ;
USE `smeagol` ;

-- -----------------------------------------------------
-- Table `smeagol`.`node_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smeagol`.`node_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `smeagol`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smeagol`.`role` (
  `type` VARCHAR(30) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `smeagol`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smeagol`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(32) NULL DEFAULT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `surname` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(150) NULL DEFAULT NULL,
  `active` INT(11) NULL DEFAULT NULL,
  `last_login` DATETIME NULL DEFAULT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  `role_type` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_role_idx` (`role_type` ASC),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_type`)
    REFERENCES `smeagol`.`role` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `smeagol`.`node`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smeagol`.`node` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `url` VARCHAR(250) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  `node_type_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_node_node_type1_idx` (`node_type_id` ASC),
  INDEX `fk_node_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_node_node_type1`
    FOREIGN KEY (`node_type_id`)
    REFERENCES `smeagol`.`node_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_node_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `smeagol`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
