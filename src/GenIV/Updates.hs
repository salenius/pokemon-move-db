module GenIV.Updates where 

import qualified GenIII.Move as Prev
import GenIV.Attribute
import GenIV.Damage
import GenIV.Effect
import GenIV.Success
import GenIII.Move ((%))

class (Attribute mv, TypeOf mv, CategorySYM mv, SideEffect mv) => GenIVMove mv
class (GenIVMove mv, Prev.GenIIIMove mv) => GenIIIMove mv
class (GenIVMove mv, Prev.GenIIMove mv) => GenIIMove mv
class (GenIVMove mv, Prev.GenIMove mv) => GenIMove mv

bodySlam :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
bodySlam = Prev.bodySlam `updateAttr` category physical

brickBreak :: (GenIIIMove mv, DamageSYM mv, ScreenSYM mv) => mv Move
brickBreak = Prev.brickBreak `updateAttr` category physical

bulkUp :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
bulkUp = Prev.bulkUp `updateAttr` category status

calmMind :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
calmMind = Prev.calmMind `updateAttr` category status

cosmicPower :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
cosmicPower = Prev.cosmicPower `updateAttr` category status

crunch :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
crunch = Prev.crunch `updateAttr` category physical

dragonClaw :: (GenIIIMove mv, DamageSYM mv) => mv Move
dragonClaw = Prev.dragonClaw `updateAttr` category physical

dragonDance :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
dragonDance = Prev.dragonDance `updateAttr` category status

earthquake ::
  (GenIMove mv,
   DamageSYM mv,
   DamageProdSYM mv,
   HitSYM mv,
   SemiInvulnerableSYM mv,
   VanishSYM mv) => mv Move
earthquake = Prev.earthquake `updateAttr` category physical

eruption :: (GenIIIMove mv, DamageSYM mv) => mv Move
eruption = Prev.eruption `updateAttr` category special

extremeSpeed :: (GenIIMove mv, DamageSYM mv) => mv Move
extremeSpeed = Prev.extremeSpeed `updateAttr` category physical

fakeOut :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv, SuccessSYM mv) => mv Move
fakeOut = Prev.fakeOut `updateAttr` category physical

hail' :: (GenIIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
hail' = Prev.hail' `updateAttr` category status

heatWave :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
heatWave = Prev.heatWave `updateAttr` category special

ironDefense :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move 
ironDefense = Prev.ironDefense `updateAttr` category status

ironTail :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
ironTail = Prev.ironTail `updateAttr` category physical

machPunch :: (GenIIMove mv, DamageSYM mv) => mv Move
machPunch = Prev.machPunch `updateAttr` category physical

magicCoat :: (GenIIIMove mv, StatusReflectionSYM mv) => mv Move
magicCoat = Prev.magicCoat `updateAttr` category status

megahorn :: (GenIIMove mv, DamageSYM mv) => mv Move
megahorn = Prev.megahorn `updateAttr` category physical

outrage :: (GenIIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv) => mv Move
outrage = Prev.outrage `updateAttr` category physical

muddyWater :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv) => mv Move
muddyWater = Prev.muddyWater `updateAttr` category special

overheat :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
overheat = Prev.overheat `updateAttr` category special

poisonFang :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
poisonFang = Prev.poisonFang `updateAttr` category physical

poisonTail :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv, DamageProdSYM mv) => mv Move
poisonTail = Prev.poisonTail `updateAttr` category physical

psychoBoost :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
psychoBoost = Prev.psychoBoost `updateAttr` category special

pursuit ::  (GenIIMove mv, DamageSYM mv, HitSYM mv, NonStrikeOpSYM mv, SuccessSYM mv) => mv Move
pursuit = Prev.pursuit `updateAttr` category physical

revenge :: (GenIIIMove mv, DamageSYM mv, DamageProdSYM mv, DamageEventSYM mv) => mv Move
revenge = Prev.revenge `updateAttr` category physical

rockBlast :: (GenIIIMove mv, DamageSYM mv) => mv Move
rockBlast = Prev.rockBlast `updateAttr` category physical

rockSlide :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
rockSlide = Prev.rockSlide `updateAttr` category physical

sheerCold :: (GenIIIMove mv, DamageSYM mv, HitSYM mv) => mv Move
sheerCold = Prev.sheerCold `updateAttr` category special

signalBeam :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
signalBeam = Prev.signalBeam `updateAttr` category special

superpower :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
superpower = Prev.superpower `updateAttr` category physical

surf ::
  (GenIMove mv,
   DamageSYM mv,
   DamageProdSYM mv,
   SemiInvulnerableSYM mv,
   VanishSYM mv) => mv Move
surf =
  Prev.surf `updateAttr` category special

taunt :: (GenIIIMove mv, TauntSYM mv, TurnSYM mv, StatusReflectionSYM mv) => mv Move
taunt = Prev.taunt `updateAttr` category status

torment ::  (GenIIIMove mv, TauntSYM mv, TurnSYM mv, StatusReflectionSYM mv) => mv Move
torment = Prev.torment `updateAttr` category status

voltTackle :: (GenIIIMove mv, DamageSYM mv, HPSYM mv) => mv Move
voltTackle = Prev.voltTackle `updateAttr` category physical

waterPulse :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
waterPulse = Prev.waterPulse `updateAttr` category special

waterSpout :: (GenIIIMove mv, DamageSYM mv) => mv Move
waterSpout = Prev.waterSpout `updateAttr` category special

willOWisp :: (GenIIIMove mv, AilmentSYM mv, StatusReflectionSYM mv) => mv Move
willOWisp = Prev.willOWisp `updateAttr` category status

yawn :: (GenIIIMove mv, AilmentSYM mv, StatusReflectionSYM mv) => mv Move
yawn = Prev.yawn `updateAttr` category status

aeroblast :: (GenIIMove mv, DamageSYM mv, DamageProdSYM mv) => mv Move
aeroblast = Prev.aeroblast `updateAttr` category special

bellyDrum :: (GenIIMove mv, ModifStatSYM mv, StatSYM mv, SuccessSYM mv, HPSYM mv) => mv Move
bellyDrum = Prev.bellyDrum `updateAttr` category status

blizzard :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
blizzard = Prev.blizzard `updateAttr` category special

boneRush :: (GenIIMove mv, DamageSYM mv) => mv Move
boneRush = Prev.boneRush `updateAttr` category physical

destinyBond :: (GenIIMove mv, FaintingSYM mv, HPSYM mv) => mv Move
destinyBond = Prev.destinyBond `updateAttr` category status

disable :: (GenIMove mv, DisableSYM mv, TurnSYM mv) => mv Move
disable = Prev.disable `updateAttr` category status

dragonBreath :: (GenIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
dragonBreath = Prev.dragonBreath `updateAttr` category special

fireBlast :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
fireBlast = Prev.fireBlast `updateAttr` category special

foresight :: (GenIIMove mv, TypeEffectSYM mv, StatChangeRemapSYM mv) => mv Move
foresight = Prev.foresight `updateAttr` category status

gigaDrain :: (GenIIMove mv, DamageSYM mv, HPSYM mv) => mv Move
gigaDrain = Prev.gigaDrain `updateAttr` category special

icyWind :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
icyWind = Prev.icyWind `updateAttr` category special

painSplit :: (GenIIMove mv, HPSYM mv) => mv Move
painSplit = Prev.painSplit `updateAttr` category status

protect :: (GenIIMove mv, ProtectionSYM mv, SuccessSYM mv) => mv Move
protect = Prev.protect `updateAttr` category status

psychic' :: (GenIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
psychic' = Prev.psychic' `updateAttr` category special

rainDance :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
rainDance = Prev.rainDance `updateAttr` category status

sacredFire :: (GenIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
sacredFire = Prev.sacredFire `updateAttr` category physical

sandstorm' :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sandstorm' = Prev.sandstorm' `updateAttr` category status

shadowBall :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
shadowBall = Prev.shadowBall `updateAttr` category special

sleepTalk :: (GenIIMove mv, SuccessSYM mv, MoveCallSYM mv, AilmentSYM mv) => mv Move
sleepTalk = Prev.sleepTalk `updateAttr` category status

sludgeBomb :: (GenIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
sludgeBomb = Prev.sludgeBomb `updateAttr` category special

solarBeam ::  (GenIMove mv, DamageSYM mv, DamageProdSYM mv, WeatherSYM mv, SuccessSYM mv, TurnSYM mv)  => mv Move
solarBeam = Prev.solarBeam `updateAttr` category special

sunnyDay :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sunnyDay = Prev.sunnyDay `updateAttr` category status

swagger :: (GenIIMove mv, StatSYM mv, ModifStatSYM mv, AilmentSYM mv) => mv Move
swagger = Prev.swagger `updateAttr` category status

thunderbolt :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
thunderbolt = Prev.thunderbolt `updateAttr` category special

thunder ::  (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv, WeatherSYM mv, HitSYM mv)  => mv Move
thunder = Prev.thunder `updateAttr` category special

toxic :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
toxic = Prev.toxic `updateAttr` category status

auroraBeam :: (GenIMove mv, DamageSYM mv, StatSYM mv, ModifStatSYM mv) => mv Move
auroraBeam = Prev.auroraBeam `updateAttr` category special

crabhammer :: (GenIMove mv, DamageSYM mv, DamageProdSYM mv) => mv Move
crabhammer = Prev.crabhammer `updateAttr` category physical

drillPeck :: (GenIMove mv, DamageSYM mv) => mv Move
drillPeck = Prev.drillPeck `updateAttr` category physical

firePunch :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
firePunch = Prev.firePunch `updateAttr` category physical

flamethrower :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
flamethrower = Prev.flamethrower `updateAttr` category special

hydroPump :: (GenIMove mv, DamageSYM mv) => mv Move
hydroPump = Prev.hydroPump `updateAttr` category special

hyperFang :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
hyperFang = Prev.hyperFang `updateAttr` category physical

iceBeam :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
iceBeam = Prev.iceBeam `updateAttr` category special

icePunch :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
icePunch = Prev.icePunch `updateAttr` category physical

leechSeed :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv, HPSYM mv) => mv Move
leechSeed = Prev.leechSeed `updateAttr` category status

lightScreen :: (GenIMove mv, DamageSYM mv, ScreenSYM mv, TurnSYM mv) => mv Move
lightScreen = Prev.lightScreen `updateAttr` category status

petalDance ::
  (GenIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv) => mv Move
petalDance = Prev.petalDance `updateAttr` category special

quickAttack :: (GenIMove mv, DamageSYM mv) => mv Move
quickAttack = Prev.quickAttack `updateAttr` category physical

recover :: (GenIMove mv, HPSYM mv) => mv Move
recover = Prev.recover `updateAttr` category status

reflect :: (GenIMove mv, DamageSYM mv, ScreenSYM mv, TurnSYM mv) => mv Move
reflect = Prev.reflect `updateAttr` category status

rest :: (GenIMove mv, AilmentSYM mv, HPSYM mv) => mv Move
rest = Prev.rest `updateAttr` category status

selfDestruct :: (GenIMove mv, DamageSYM mv, HPSYM mv) => mv Move
selfDestruct = Prev.selfDestruct `updateAttr` category physical

sleepPowder :: (GenIMove mv, AilmentSYM mv) => mv Move
sleepPowder = Prev.sleepPowder `updateAttr` category status

strength :: (GenIMove mv, DamageSYM mv) => mv Move
strength = Prev.strength `updateAttr` category physical

swordsDance :: (GenIMove mv, StatSYM mv, ModifStatSYM mv) => mv Move
swordsDance = Prev.swordsDance `updateAttr` category status

thrash :: (GenIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv) => mv Move
thrash = Prev.thrash `updateAttr` category physical

waterfall :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
waterfall =
  Prev.waterfall
  `updateAttr` category physical
  `replaceEffect` (20 % affect target flinched)
