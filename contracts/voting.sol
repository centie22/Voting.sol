//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VotingContact{
    uint ID = 1;
    address owner;

    struct POLL{
        //uint Id;
        string pollTitle;
        uint durationForVoting;
        string candidates;
    }

    modifier OnlyOwner(){
        require(msg.sender == owner, "Only the owner can update this");
        _;
    } 


    address [] public eligibleVoters;

    mapping(uint => POLL) pollTracking;

    function addEligibleVoters(address voters) public OnlyOwner{
        eligibleVoters.push(voters);
    }

    function createPoll(string memory _pollTitle, uint _pollTiming, string memory _pollCandidates) public {
        POLL storage voteContent = pollTracking[ID];
        //voteContent.Id = ID;
        voteContent.pollTitle = _pollTitle;
        voteContent.durationForVoting = _pollTiming;
        voteContent.candidates = _pollCandidates;
        //voteContent.inputs = _inputs;
        ID++;
    }

    function checkEligibility() public view returns(bool status) {
        for(uint i=0; i <eligibleVoters.length; i++){
            if(msg.sender == eligibleVoters[i]) {
                status = true;
            } else {
                status = false;            }
            // require(msg.sender[i]);
        }
    }

    // function placeVote() public{
    //     require(msg.sender != address(0), "Invalid address")
    //     //require(msg.sender )

    // }

    function getVote(uint _id) public view returns(POLL memory){
       // POLL storage voteContent = pollsTracking[ID];
        return pollTracking[_id];
    }
}