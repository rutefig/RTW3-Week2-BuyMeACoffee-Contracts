import { ethers } from "hardhat"
import { expect } from "chai";

describe("BuyMeACoffee", function () {
    it("Should be able to deploy the contract", async function () {
        const [owner, tipper] = await ethers.getSigners()

        const BuyMeACoffee = await ethers.getContractFactory("BuyMeACoffee")
        const buyMeACoffee = await BuyMeACoffee.deploy()

        await buyMeACoffee.deployed()

        expect(buyMeACoffee.address).to.be.string
    })
});
