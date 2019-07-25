Class {
	#name : #BaselineOfProjectSelector,
	#superclass : #BaselineOf,
	#category : #BaselineOfProjectSelector
}

{ #category : #baselines }
BaselineOfProjectSelector >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'ProjectSelector' ]
]
