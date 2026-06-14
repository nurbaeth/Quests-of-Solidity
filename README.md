# 🧩 Quests of Solidity            
           
**Quests of Solidity** is an on-chain puzzle game where each quest is a smart contract level.          
Players must solve logic-based challenges by submitting correct answers directly on-chain.          
              
No frontend. No rewards. Just pure Solidity brainwork.          
           
---          
          
## 🎮 Gameplay      
           
1. Call `getCurrentQuest()` to get the quest description.          
2. Think. Solve the puzzle.         
3. Call `submitAnswer("yourAnswer")`.          
4. If correct → next quest unlocked.       
5. If wrong → try again.       
        
Your progress is stored on-chain.      
     
---      
     
## 🔐 Example    
    
```solidity   
// Quest description: "What Solidity keyword defines a read-only function?"  
submitAnswer("view"); 
