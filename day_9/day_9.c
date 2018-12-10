#include <stdio.h>
#include <stdlib.h>

void assert(int Condition) {
    if (!Condition) {
        printf("Assertion failed!\n");
        int *ptr = 0;
        *ptr = 0;
    }
}

int find_max(int *Array, int L)
{
	int Max = 0;
	for (int i = 0; i < L; i++) {
		if (Array[i] > Max) {
			Max = Array[i];
		}
	}
	return Max;
}

unsigned long long find_max_ull(unsigned long long *Array, int L)
{
    unsigned long long Max = 0;
    for (int i = 0; i < L; i++) {
        if (Array[i] > Max) {
            Max = Array[i];
        }
    }
    printf("Max Value is %llu \n", Max);
    return Max;
}

void insert_at_index(int *Array, int L, int Value, int Index)
{
	// NOTE: This requires Array to have been allocated at least L+1 slots so that we have room to insert
	for (int i = L-1; i >= Index; i--) {
		Array[i+1] = Array[i];
	}
	Array[Index] = Value;
}

void remove_at_index(int *Array, int L, int Index)
{
    for (int i = Index; i < L-1; i++) {
        Array[i] = Array[i+1];
    }
    Array[L-1] = 0;
}

void print_array(int *Array, int L)
{
	for (int i = 0; i < L; i++) {
		printf("%d, ", Array[i]);
	}
	printf("\n");
}

void print_array_ull(unsigned long long *Array, int L)
{
    for (int i = 0; i < L; i++) {
        printf("%llu, ", Array[i]);
    }
    printf("\n");
}

typedef struct _node {
    int value;
    _node *next;
    _node *prev;
} node; 

node *insert_node(node *Node, int Value) {
    // Inserts a new node BEFORE the Node that is given. 
    node *NewNode = (node *)malloc(sizeof(node));
    NewNode->value = Value; 
    NewNode->prev = Node->prev; 
    NewNode->next = Node; 

    node *PrevNode = Node->prev;
    PrevNode->next = NewNode;

    Node->prev = NewNode; 

    return NewNode; 
}

node *remove_node(node *Node) {

    node *PrevNode = Node->prev;
    node *NextNode = Node->next;
    int Value = Node->value; 

    NextNode->prev = PrevNode;
    PrevNode->next = NextNode;
    free(Node);

    return NextNode;
}

node *shift_deque(node *Node, int Shift) {
    node *ShiftedNode = Node;
    
    if (Shift > 0) {
        for (int i = 0; i < Shift; i++) {
            ShiftedNode = ShiftedNode->next; 
        }
    } else if (Shift < 0) {
        for (int i = 0; i < -Shift; i++) {
            ShiftedNode = ShiftedNode->prev;
        }
    } 
    return ShiftedNode; 
}

void print_deque(node *Node, int L) {
    node *CurrNode = Node;
    for (int i = 0; i < L; i++) {
        printf("%d, ", CurrNode->value);
        CurrNode = CurrNode->next; 
    }
    printf("\n");
}

unsigned long long simulate_marble_game_deque(int NumPlayers, int LastMarble)
{
    node *Circle = (node *)malloc(sizeof(node));
    Circle->value = 0; 
    Circle->next = Circle->prev = Circle;
    Circle = insert_node(Circle, 1);
    Circle->prev = Circle->next;
    Circle->prev->prev = Circle;
    Circle->next->next = Circle;

    int CurrMarble = 2;
    int L = 2; 
    unsigned long long Scores[NumPlayers];
    for (int i = 0; i < NumPlayers; i++) {
        Scores[i] = 0;
    }
    int PlayerIndex = 0;

    while (CurrMarble <= LastMarble) {
    
        if (CurrMarble%23 != 0) {
            Circle = shift_deque(Circle, 2);
            Circle = insert_node(Circle, CurrMarble);
            L++;
        } else {
            Circle = shift_deque(Circle, -7);
            int RemovedMarble = Circle->value;
            Circle = remove_node(Circle);
            Scores[PlayerIndex] += RemovedMarble + CurrMarble;
            L--;
        }

        CurrMarble = CurrMarble+1; // Get the next marble
        PlayerIndex = (PlayerIndex + 1) % NumPlayers; // Get the next player index

    }

    return find_max_ull(Scores, NumPlayers);

}

// int simulate_marble_game(int NumPlayers, int LastMarble)
// {
// 	int FinalLength =  1 + LastMarble - 2*(LastMarble/23);
// 	int *Circle = (int *)calloc(FinalLength, sizeof(int));
   
//     // Circle = [0 2 1];
//     Circle[0] = 0;
//     Circle[1] = 2;
//     Circle[2] = 1;

//     int PlayerIndex = 2;
//     int CurrMarble = 2;
//     int InsertionIndex = 3;
//     int L = 3;

//     Scores[NumPlayers];
//     for (int i = 0; i < NumPlayers; i++) {
//         Scores[i] = 0;
//     }

//     while (CurrMarble < LastMarble) {
//         if (CurrMarble % 1000 == 0) {
//             printf("CurrMarble = %d\n", CurrMarble);
//         }
//         CurrMarble = CurrMarble+1; // Get the next marble
        
//         if (CurrMarble%23 != 0) {
//             if (InsertionIndex > L) {
//                 InsertionIndex = InsertionIndex % L;
//             }
//             insert_at_index(Circle, L, CurrMarble, InsertionIndex);
//             L++;
//             InsertionIndex = InsertionIndex + 2;
//         } else {
//             int RemovalIndex = InsertionIndex - 9;
//             if (RemovalIndex < 0) {
//                 RemovalIndex = RemovalIndex + L;
//             }
            
//             Scores[PlayerIndex] += Circle[RemovalIndex] + CurrMarble;
//             remove_at_index(Circle, L, RemovalIndex);
//             L--;
//             InsertionIndex = RemovalIndex+2;
//         }

//         PlayerIndex = (PlayerIndex + 1) % NumPlayers; // Get the next player index
//         // assert(CurrLength == 1 + CurrMarble - 2*fix(CurrMarble/23)); 
//     }
//     assert(L == FinalLength);
//     int MaxScore = find_max(Scores, NumPlayers);
//     return MaxScore;
// }



int main() {

	int NumPlayers = 459;
	int LastMarble = 71790;

    unsigned long long HighestScore = simulate_marble_game_deque(NumPlayers, LastMarble);
    printf("For NumPlayers = %d, LastMarble = %d, HighestScore = %llu\n", NumPlayers, LastMarble, HighestScore);

    NumPlayers = 459;
    LastMarble = 71790*100;
    
    HighestScore = simulate_marble_game_deque(NumPlayers, LastMarble);
    printf("For NumPlayers = %d, LastMarble = %d, HighestScore = %llu\n", NumPlayers, LastMarble, HighestScore);

	return 0;
}