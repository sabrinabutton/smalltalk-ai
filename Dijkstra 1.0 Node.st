'From Pharo7.0.4 of 13 August 2019 [Build information: Pharo-7.0.4+build.168.sha.ccd1f6489120f58ddeacb2cac77cd3a0f0dcfbe6 (64 Bit)] on 6 February 2020 at 8:34:44.75253 pm'!
Object subclass: #DijkstraNode
	instanceVariableNames: 'energy idealpath singularenergy location'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JRMPC-Phase1-Minds'!

!DijkstraNode methodsFor: 'as yet unclassified' stamp: 'SabrinaButton 2/3/2020 18:11'!
parentPath: anOrderedCollection
	idealpath:= anOrderedCollection.! !

!DijkstraNode methodsFor: 'as yet unclassified' stamp: 'SabrinaButton 2/5/2020 19:36'!
location: thisLocation
	location:= thisLocation. ! !


!DijkstraNode methodsFor: 'accessing' stamp: 'SabrinaButton 2/3/2020 18:24'!
energy 
	^energy.! !

!DijkstraNode methodsFor: 'accessing' stamp: 'SabrinaButton 2/3/2020 18:10'!
idealpath
	^idealpath.! !

!DijkstraNode methodsFor: 'accessing' stamp: 'SabrinaButton 2/4/2020 19:53'!
location
	^location.! !


!DijkstraNode methodsFor: 'initialization' stamp: 'SabrinaButton 2/5/2020 17:46'!
setEnergy: soleEnergy
	"Energy of this node."
	energy:= soleEnergy.
	! !

!DijkstraNode methodsFor: 'initialization' stamp: 'SabrinaButton 2/5/2020 19:46'!
initialize
	"Initialize instance variables."
	super initialize.
	singularenergy:= 0.
	energy:= 0.
	idealpath:= OrderedCollection new.! !

!DijkstraNode methodsFor: 'initialization' stamp: 'SabrinaButton 2/3/2020 18:09'!
setPrevious: parentenergy
	"comment stating purpose of message"

	energy:= energy + parentenergy.! !

!DijkstraNode methodsFor: 'initialization' stamp: 'SabrinaButton 2/5/2020 17:46'!
setDir: aDirection
	idealpath add: aDirection.! !
