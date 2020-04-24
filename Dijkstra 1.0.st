'From Pharo7.0.4 of 13 August 2019 [Build information: Pharo-7.0.4+build.168.sha.ccd1f6489120f58ddeacb2cac77cd3a0f0dcfbe6 (64 Bit)] on 6 February 2020 at 8:34:40.78153 pm'!
RobotMind subclass: #DijkstraTen
	instanceVariableNames: 'path pathIndex priority moves finished'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JRMPC-Phase1-Minds'!

!DijkstraTen methodsFor: 'initialization' stamp: 'SabrinaButton 2/6/2020 20:14'!
pathBuilder: robot
	"comment stating purpose of message"
	| currentCell newCell tempDir toAdd  thisNeighbor robotCell|

	"Add trobots current cell to toCheck"
	robotCell:=  self starterCell: robot.
	priority add: robotCell.			


1 to: moves do: [ :i |
		currentCell:= priority at: 1.
		
		"Add neighbors of the current cell."
		
		currentCell location fourNeighbors collect: [ :point |
				
			thisNeighbor:= robot map cellAt: (robot map normalizePoint: point).
				
				
			"Create a new node for the current neighbor"		
			newCell:= DijkstraNode new.
	
			"Set node energy to neighbor energy"
			newCell setEnergy: thisNeighbor energy. 
			
			"Set location to neighbor location"
			newCell location: thisNeighbor location.
						
			
			"Set previous energy to that of previous cell"
			newCell setPrevious: currentCell energy.
			
			"Set path"
			newCell parentPath: currentCell idealpath.
			
			"Find direction of this move and add it"
			tempDir:= self oldLocation: currentCell location newLocation: newCell location. 
			
			newCell setDir: tempDir.
			
			path add: tempDir.
			
			"Add the new cell to the list of paths to check paths."
			priority add: newCell.	
			
			].
		"Add the current to finished."
		finished add: currentCell.
		
		"Remove current cell from priority."
		priority remove: currentCell.
]. 

"Get the path from the first prioritized cell"
toAdd:= finished at: 1.
path:= toAdd idealpath.
! !

!DijkstraTen methodsFor: 'initialization' stamp: 'SabrinaButton 2/3/2020 18:28'!
moves 
	^10.! !

!DijkstraTen methodsFor: 'initialization' stamp: 'SabrinaButton 2/4/2020 20:29'!
initialize
	"Initialize instance variables."
	super initialize.
	path:= OrderedCollection new.
	pathIndex:= 1.
	priority:= SortedCollection 
			sortBlock: [ :n1 :n2 | n1 energy <= n2 energy ].
	finished:= SortedCollection 
		sortBlock: [ :n1 :n2 | n1 energy <= n2 energy ].
	moves:= 10.
	! !


!DijkstraTen methodsFor: 'access' stamp: 'SabrinaButton 2/2/2020 15:22'!
oldX: ox oldY: oy newX: nx newY: ny
	
	nx > ox
		ifTrue: [ 
				^RobotEast soleInstance.
			 ].
	nx < ox
		ifTrue: [ 
				^RobotWest soleInstance.
			 ].
	ny > oy
		ifTrue: [ 
				^RobotSouth soleInstance.
			 ].
	ny < oy
		ifTrue: [ 
				^RobotNorth soleInstance.
			 ].! !


!DijkstraTen methodsFor: 'running' stamp: 'SabrinaButton 2/6/2020 20:16'!
determineDirectionForRobot: robot
	
	"Build a path if index is 1 (we just started)"
	pathIndex = 1 
		ifTrue:[	
		self pathBuilder: robot.
	].

"TODO at: pathIndex"
	direction:= path at: pathIndex.
	
	"Increment the path index."
	pathIndex:= pathIndex + 1.
	
	"If path index is 11 (above 10, our limit) reset the index."
   pathIndex = 11
		 ifTrue:[
		path removeAll.	
			priority removeAll.	
				finished removeAll.	
		pathIndex:= 1.
	].! !


!DijkstraTen methodsFor: 'accessing' stamp: 'SabrinaButton 2/4/2020 20:30'!
priority 	
	^priority.! !

!DijkstraTen methodsFor: 'accessing' stamp: 'SabrinaButton 2/3/2020 18:26'!
pathIndex
	^pathIndex.! !

!DijkstraTen methodsFor: 'accessing' stamp: 'SabrinaButton 2/4/2020 20:30'!
finished
	^finished.! !


!DijkstraTen methodsFor: 'as yet unclassified' stamp: 'SabrinaButton 2/5/2020 17:31'!
oldLocation: locationO newLocation: locationN

	locationN x > locationO x
		ifTrue: [ 
				^RobotEast soleInstance.
			 ].
	locationN x < locationO x
		ifTrue: [ 
				^RobotWest soleInstance.
			 ].
	locationN y > locationO y
		ifTrue: [ 
				^RobotSouth soleInstance.
			 ].
	locationN y < locationO y
		ifTrue: [ 
				^RobotNorth soleInstance.
			 ].! !

!DijkstraTen methodsFor: 'as yet unclassified' stamp: 'SabrinaButton 2/5/2020 19:40'!
starterCell: robot
		|cell|
			"Create a new node"		
			cell:= DijkstraNode new.
	
			"Set node energy to 0"
			cell setEnergy: 0. 
			
			"Set location to neighbor location"
			cell location: robot location.
			
			"Set previous energy to that of previous cell"
			cell setPrevious: 0.
			
		^cell.! !
