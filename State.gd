## ------------------------------------------------------------------
## State.gd — Clase base abstracta para todos los estados del Player.
## Requisitos de diseño (acordados):
## - Agnóstico de la capa de animación (usa AnimationManager externo).
## - Cada estado declara a qué estados puede transicionar (claridad docente).
## - Solo el estado ACTIVO procesa _physics_process (el SM enciende/apaga).
## - El PlayerController se limita a controlar al jugador (UI afuera).
## ------------------------------------------------------------------
class_name State
extends Node

## Referencias inyectadas por la StateMachine en _ready():
var machine: Node                 ## StateMachine
var actor: CharacterBody2D        ## PlayerController (o similar)
var anim                          ## AnimationManager (contrato abstracto)

## (Opcional) Identificador formal del estado. Por defecto, el nombre del nodo.
func id() -> StringName:
	return name

## Transiciones permitidas desde este estado (por nombre de hijo bajo "States").
## Mantener breve y preciso. Esto es material docente.
func allowed_transitions() -> Array[StringName]:
	return []  # Ej: return [&"Walk", &"Jump"]

## Señal de entrada al estado. 'msg' puede transportar datos contextuales.
func enter(msg: Dictionary = {}) -> void:
	pass

## Señal de salida del estado.
func exit() -> void:
	pass

## Manejo de input específico de avatar. La UI NO llega aquí.
func handle_input(event: InputEvent) -> void:
	pass

## Tick de física del estado ACTIVO. No hacer lógica si el estado no está activo.
func update(delta: float) -> void:
	pass

## Utilidades protegidas para pedir transiciones de forma declarativa.
func request(to: StringName, ctx: Dictionary = {}) -> bool:
	return machine.request_transition(to, ctx)

## Helper para consultar si una transición es legal (útil en ventanas/cancel).
func can_request(to: StringName, ctx: Dictionary = {}) -> bool:
	return machine.can_transition_to(to, ctx)
