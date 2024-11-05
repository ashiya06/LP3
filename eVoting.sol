pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint voteCount;
        uint id;
    }

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint vote;
    }

    address public admin;
    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    bool public electionActive;
    bool public voterRegistrationActive;
    uint public totalVotes;

    event ElectionStarted();
    event ElectionEnded();
    event VoteCasted(address voter, uint candidateIndex);
    event CandidateAdded(string name, uint id);
    event VoterRegistered(address voter);

    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0,
                id: i
            }));
        }
        voterRegistrationActive = true;
        electionActive = false;
        totalVotes = 0;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    modifier electionOngoing() {
        require(electionActive, "Election is not active.");
        _;
    }

    modifier electionEnded() {
        require(!electionActive, "Election is still ongoing.");
        _;
    }

    modifier registrationOpen() {
        require(voterRegistrationActive, "Voter registration is closed.");
        _;
    }

    // Voter registration function
    function registerVoter(address voter) public onlyAdmin registrationOpen {
        require(!voters[voter].isRegistered, "Voter is already registered.");
        voters[voter].isRegistered = true;
        emit VoterRegistered(voter);
    }

    // Close voter registration
    function closeVoterRegistration() public onlyAdmin {
        voterRegistrationActive = false;
    }

    // Function to add candidates
    function addCandidate(string memory name) public onlyAdmin {
        candidates.push(Candidate({
            name: name,
            voteCount: 0,
            id: candidates.length
        }));
        emit CandidateAdded(name, candidates.length - 1);
    }

    // Start election
    function startElection() public onlyAdmin {
        require(!electionActive, "Election already active.");
        require(!voterRegistrationActive, "Close voter registration first.");
        electionActive = true;
        emit ElectionStarted();
    }

    // Voting function
    function vote(uint candidateIndex) public electionOngoing {
        require(voters[msg.sender].isRegistered, "You are not registered to vote.");
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate index.");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].vote = candidateIndex;
        candidates[candidateIndex].voteCount++;
        totalVotes++;
        
        emit VoteCasted(msg.sender, candidateIndex);
    }

    // End election
    function endElection() public onlyAdmin electionOngoing {
        electionActive = false;
        emit ElectionEnded();
    }

    // Get the winner of the election
    function getWinner() public view electionEnded returns (string memory winner, uint winningVoteCount) {
        uint maxVoteCount = 0;
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVoteCount) {
                maxVoteCount = candidates[i].voteCount;
                winner = candidates[i].name;
                winningVoteCount = candidates[i].voteCount;
            }
        }
    }

    // Allow admin to recount votes if there’s a dispute
    function recountVotes() public view onlyAdmin electionEnded returns (Candidate[] memory) {
        return candidates;
    }

    // Reset election for the next round
    function resetElection() public onlyAdmin {
        for (uint i = 0; i < candidates.length; i++) {
            candidates[i].voteCount = 0;
        }
        totalVotes = 0;

        for (uint j = 0; j < voters[msg.sender].vote; j++) {
            voters[msg.sender].hasVoted = false;
        }

        electionActive = false;
        voterRegistrationActive = true;
    }

    // Get total number of candidates
    function getTotalCandidates() public view returns (uint) {
        return candidates.length;
    }

    // Get candidate details
    function getCandidate(uint candidateIndex) public view returns (string memory name, uint voteCount, uint id) {
        require(candidateIndex < candidates.length, "Candidate does not exist.");
        return (candidates[candidateIndex].name, candidates[candidateIndex].voteCount, candidates[candidateIndex].id);
    }

    // View voter details
    function getVoter(address voterAddress) public view returns (bool isRegistered, bool hasVoted, uint vote) {
        Voter memory voter = voters[voterAddress];
        return (voter.isRegistered, voter.hasVoted, voter.vote);
    }

    // Function to check if election is active
    function isElectionActive() public view returns (bool) {
        return electionActive;
    }

    // Function to check if voter registration is active
    function isVoterRegistrationActive() public view returns (bool) {
        return voterRegistrationActive;
    }
}
