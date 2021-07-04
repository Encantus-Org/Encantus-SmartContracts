// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Encantus {
  string public name;
  uint public songCount = 0;
  mapping(uint => Song) public songs;

  struct Song {
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address payable author;
  }

  event SongCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  event SongTipped(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  constructor() public {
    name = "Encantus";
  }

  function uploadSong(string memory _songHash, string memory _description) public {
    // Make sure the song hash exists
    require(bytes(_songHash).length > 0);
    // Make sure song description exists
    require(bytes(_description).length > 0);
    // Make sure uploader address exists
    require(msg.sender!=address(0));

    // Increment song id
    songCount ++;

    // Add Song to the contract
    songs[songCount] = Song(songCount, _songHash, _description, 0, msg.sender);
    // Trigger an event
    emit SongCreated(songCount, _songHash, _description, 0, msg.sender);
  }

  function tipSongOwner(uint _id) public payable {
    // Make sure the id is valid
    // Fetch the song
    // Fetch the author
    // Pay the author by sending them Ether
    // Increment the tip amount
    // Update the song
    // Trigger an event
    
    require(_id > 0 && _id <= songCount);
    
    Song memory _song = songs[_id];
    
    address payable _author = _song.author;
    
    address(_author).transfer(msg.value);
    
    _song.tipAmount = _song.tipAmount + msg.value;
    
    songs[_id] = _song;
    
    emit SongTipped(_id, _song.hash, _song.description, _song.tipAmount, _author);
  }
}