// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Quests of Solidity - On-chain puzzle game
contract QuestsOfSolidity {
    address public owner;
    uint256 public totalQuests;

    struct Quest {
        string description;      // описание задания
        bytes32 answerHash;      // хеш правильного ответа
        bool isActive;
    }

    mapping(uint256 => Quest) public quests;
    mapping(address => uint256) public playerProgress;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    event QuestCreated(uint256 questId, string description);
    event QuestSolved(address player, uint256 questId);

    constructor() {
        owner = msg.sender;
    }

    /// @notice Добавляет новый квест
    function createQuest(string memory _description, string memory _answer) external onlyOwner {
        quests[totalQuests] = Quest({
            description: _description,
            answerHash: keccak256(abi.encodePacked(_answer)),
            isActive: true
        });

        emit QuestCreated(totalQuests, _description);
        totalQuests++;
    }

    /// @notice Получить описание текущего квеста игрока
    function getCurrentQuest() external view returns (string memory) {
        uint256 questId = playerProgress[msg.sender];
        require(questId < totalQuests, "All quests completed");
        return quests[questId].description;
    }

    /// @notice Отправить ответ на квест
    function submitAnswer(string memory _answer) external {
        uint256 questId = playerProgress[msg.sender];
        require(questId < totalQuests, "Game completed");
        require(quests[questId].isActive, "Quest not active");

        if (keccak256(abi.encodePacked(_answer)) == quests[questId].answerHash) {
            playerProgress[msg.sender]++;
            emit QuestSolved(msg.sender, questId);
        } else {
            revert("Wrong answer, try again");
        }
    }
}
