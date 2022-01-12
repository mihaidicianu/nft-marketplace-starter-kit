const { assert } = require("chai");

const KryptoBird = artifacts.require("./KryptoBird");

require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("KryptoBird", (accounts) => {
  let contract;
  before(async () => {
    contract = await KryptoBird.deployed();
  });

  describe("deployment", async () => {
    it("deploys successfuly", async () => {
      const address = contract.address;
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    it("good internal vars", async () => {
      assert.equal(await contract.name(), "KryptoBird");
      assert.equal(await contract.symbol(), "KBIRDZ");
    });
  });

  describe("minting", async () => {
    it("creates a new token", async () => {
      const result = await contract.mint("https...1");
      const totalSupply = await contract.totalSupply();
      assert.equal(totalSupply, 1);
      const event = result.logs[0].args;
      assert.equal(event._from, contract.address);
      assert.equal(event._to, accounts[0]);

      await contract.mint("https...1").should.be.rejected;
    });
  });

  describe("indexing", async () => {
    it("lists KBIRDZ", async () => {
      await contract.mint("https...2");
      await contract.mint("https...3");
      await contract.mint("https...4");
      assert.equal(contract.totalSupply(), 4);
      let result = [];
      let KryptoBird;
      for (i = 1; i < totalSupply; i++) {
        KryptoBird = await contract.kryptoBirdz(i - 1);
        result.push(KryptoBird);
      }
      let expected = ["https...1", "https...2", "https...3", "https...4"];
    });
  });
});
