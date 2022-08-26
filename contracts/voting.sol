//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VotingContact {

    address owner;
   // uint ID;

    struct POLL{
        uint count;
        uint durationForVoting;
        string candidates;
    }

    modifier OnlyOwner(){
        require(msg.sender == owner, "Only the owner can update this");
        _;
    } 

    address[] public eligibleVoters;

    mapping(uint => POLL) pollTrack;

    function addEligibleVoters(address voters) public OnlyOwner{
        eligibleVoters.push(voters);
    }

    function createPoll(uint _pollTiming, string memory _pollCandidates, uint ID) public {
        POLL storage votepoll = pollTrack[ID];
        //voteContent.Id = ID;
        votepoll.durationForVoting = _pollTiming + block.timestamp;
        votepoll.candidates = _pollCandidates;
        
        
    }

    function checkEligibility(address voter) internal view returns(bool status) {
        for(uint i=0; i <eligibleVoters.length; i++){
            if(voter == eligibleVoters[i]) {
                status = true;
            } else {
                status = false;
            }
        }
    }

    function placeVote(uint ID) public {
        require(msg.sender != address(0), "Invalid address");
        require(checkEligibility(msg.sender), "Not eligible to vote");

        POLL storage votepoll = pollTrack[ID];
        votepoll.count++;
    }

    function getVote(uint _id) public view returns(POLL memory){
       // POLL storage voteContent = pollsTracking[ID];
        return pollTrack[_id];
    }
}