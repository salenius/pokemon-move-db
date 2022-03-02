module GenIV.Move where

import qualified GenIII.Move as Prev
import GenIII.Move
import GenIV.Attribute
import GenIV.Effect
import GenIV.Damage
import GenIV.Success

class (Attribute mv, TypeOf mv, CategorySYM mv, SideEffect mv) => GenIVMove mv

airSlash :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
airSlash =
  name "Air Slash"
  `having`
  pp 20 <>
  typeOf flying <>
  category special <>
  accuracy 0.95
  `effects`
  basepower 75
  `afterDamage`
  30 % affect target flinched

aquaJet :: (GenIVMove mv, DamageSYM mv) => mv Move
aquaJet = aquaJetVariation "Aqua Jet" water

auraSphere :: (GenIVMove mv, DamageSYM mv) => mv Move
auraSphere =
  name "Aura Sphere"
  `having`
  pp 20 <>
  typeOf fighting <>
  category special
  `effects`
  damageWithBasepower 90

braveBird :: (GenIVMove mv, DamageSYM mv, HPSYM mv) => mv Move
braveBird = flareBlitzVariation "Brave Bird" flying noEffect

bugBuzz :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
bugBuzz = earthPowerVariation "Bug Buzz" ground 90

bulletPunch :: (GenIVMove mv, DamageSYM mv) => mv Move
bulletPunch = aquaJetVariation "Bullet Punch" steel

closeCombat :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
closeCombat =
  name "Close Combat"
  `having`
  pp 5 <>
  typeOf fighting <>
  category physical <>
  makesContact <>
  accuracy 1.0
  `effects`
  basepower 120
  `afterDamage`
  affect user (raise defenceStat minus1) `andAlso`
  affect user (raise spDefenceStat minus1)

darkPulse :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
darkPulse = darkPulseVariation "Dark Pulse" 15 dark 20 flinched

dracoMeteor :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
dracoMeteor = leafStormVariation "Draco Meteor" dragon

dragonPulse :: (GenIVMove mv, DamageSYM mv) => mv Move
dragonPulse =
  name "Dragon Pulse"
  `having`
  pp 10 <>
  typeOf dragon <>
  accuracy 1.0
  `effects`
  damageWithBasepower 90

earthPower :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
earthPower = earthPowerVariation "Earth Power" ground 90

energyBall :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
energyBall = earthPowerVariation "Energy Ball" grass 80

fireFang :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
fireFang = iceFangVariation "Fire" fire burned

flashCannon :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
flashCannon = earthPowerVariation "Flash Cannon" steel 80

flareBlitz :: (GenIVMove mv, DamageSYM mv, HPSYM mv, AilmentSYM mv) => mv Move
flareBlitz = flareBlitzVariation "Flare Blitz" fire (thaw user)

focusBlast :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
focusBlast = earthPowerVariation "Focus Blast" fighting 120
  `updateAttr` accuracy 0.7
  `updateAttr` pp 5

hammerArm :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
hammerArm =
  name "Hammer Arm"
  `having`
  pp 10 <>
  typeOf fighting <>
  category physical <>
  makesContact <>
  accuracy 0.9
  `effects`
  basepower 100
  `afterDamage`
  affect user (raise speedStat minus1)

headSmash :: (GenIVMove mv, DamageSYM mv, HPSYM mv) => mv Move
headSmash =
  name "Head Smash"
  `having`
  pp 5 <>
  typeOf rock <>
  category physical <>
  makesContact <>
  accuracy 0.8
  `effects`
  basepower 150
  `afterDamage`
  recoil 0.5

iceFang :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
iceFang = iceFangVariation "Ice" ice frozen

iceShard :: (GenIVMove mv, DamageSYM mv) => mv Move
iceShard = aquaJetVariation "Ice Shard" ice

ironHead :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
ironHead = poisonJabVariation "Iron Head" steel flinched

leafStorm :: (GenIVMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
leafStorm = leafStormVariation "Leaf Storm" grass

poisonJab :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
poisonJab = poisonJabVariation "Poison Jab" poison (make poisoned)

powerGem :: (GenIVMove mv, DamageSYM mv) => mv Move
powerGem = seedBombVariation "Power Gem" 20 rock `updateAttr` category special

shadowSneak :: (GenIVMove mv, DamageSYM mv) => mv Move
shadowSneak = aquaJetVariation "Shadow Sneak" ghost

seedBomb :: (GenIVMove mv, DamageSYM mv) => mv Move
seedBomb = seedBombVariation "Seed Bomb" 15 grass

stoneEdge :: (GenIVMove mv, DamageSYM mv, DamageProdSYM mv) => mv Move
stoneEdge =
  name "Stone Edge"
  `having`
  pp 5 <>
  typeOf rock <>
  category physical <>
  accuracy 0.8
  `effects`
  basepower 100 *.
  increasedCriticalHitRatio 1
  `afterDamage`
  noEffect

suckerPunch :: (GenIVMove mv, DamageSYM mv, TargetMoveReqSYM mv, SuccessSYM mv) => mv Move
suckerPunch =
  name "Sucker Punch"
  `having`
  pp 5 <>
  typeOf dark <>
  category physical <>
  accuracy 1.0 <>
  makesContact <>
  priority 1
  `effects`
  targetChoseNonStatusMove
  `afterSucceeding`
  basepower 80
  `afterDamage`
  noEffect

thunderFang :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
thunderFang = iceFangVariation "Thunder" electric paralyzed

uTurn :: (GenIVMove mv, DamageSYM mv, SwitchPokemonSYM mv) => mv Move
uTurn =
  name "U-Turn"
  `having`
  pp 20 <>
  typeOf bug <>
  category physical <>
  makesContact <>
  accuracy 1.0
  `effects`
  basepower 70
  `afterDamage`
  affect user switchAnotherPokemon

vacuumWave :: (GenIVMove mv, DamageSYM mv) => mv Move
vacuumWave = quickAttackVariation "Vacuum Wave" fighting `updateAttr` category special

woodHammer :: (GenIVMove mv, DamageSYM mv, HPSYM mv) => mv Move
woodHammer = flareBlitzVariation "Wood Hammer" grass noEffect

xScissor ::  (GenIVMove mv, DamageSYM mv) => mv Move
xScissor = seedBombVariation "Seed Bomb" 15 bug

zenHeadbutt :: (GenIVMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
zenHeadbutt =
  name "Zen Headbutt"
  `having`
  pp 15 <>
  typeOf psychic <>
  category physical <>
  accuracy 0.9 <>
  makesContact
  `effects`
  basepower 80
  `afterDamage`
  20 % affect target flinched

---

aquaJetVariation nm t = quickAttackVariation nm t `updateAttr` category physical

leafStormVariation nm t = overheatVariation nm t `updateAttr` category special

seedBombVariation nm p t =
  strengthVariation nm p t
  `updateAttr` makesContact
  `updateAttr` category physical

darkPulseVariation nm p t pct eff =
  name nm
  `having`
  pp p <>
  typeOf t <>
  accuracy 1.0 <>
  category special
  `effects`
  basepower 80
  `afterDamage`
  pct % affect target eff

poisonJabVariation nm t eff = darkPulseVariation nm 20 t 30 eff
  `updateAttr` category physical
  `updateAttr` makesContact

flareBlitzVariation nm t preveff =
  name nm
  `having`
  pp 15 <>
  typeOf t <>
  accuracy 1.0 <>
  category physical <>
  makesContact
  `effects`
  (basepower 120
  `beforeDamage`
  preveff)
  `afterDamage`
  recoil 0.333

earthPowerVariation nm t bp =
  name nm
  `having`
  pp 10 <>
  typeOf t <>
  accuracy 1.0 <>
  category special
  `effects`
  basepower bp
  `afterDamage`
  10 % affect target (raise spDefenceStat minus1)

iceFangVariation nm t eff =
  name (nm <> " Fang")
  `having`
  pp 15 <>
  typeOf t <>
  accuracy 0.95 <>
  category physical <>
  makesContact
  `effects`
  basepower 65
  `afterDamage`
  (10 % affect target flinched) `andAlso`
  (10 % affect target (make eff))
