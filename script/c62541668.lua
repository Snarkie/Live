--Scripted by Eerie Code
--Number 77: The Seven Sins
function c62541668.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,2,c62541668.ovfilter,aux.Stringid(62541668,0),2,c62541668.xyzop)
	c:EnableReviveLimit()
	--Banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62541668,1))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c62541668.rmcost)
	e1:SetTarget(c62541668.rmtg)
	e1:SetOperation(c62541668.rmop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c62541668.reptg)
	c:RegisterEffect(e2)
end
c62541668.xyz_number=77
function c62541668.ovfilter(c)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK) and (rk==10 or rk==11)
end
function c62541668.xyzop(e,tp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(62541668,RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END,0,1)
end

function c62541668.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c62541668.rmfil(c)
	return c:IsAbleToRemove() and c:IsFaceup() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c62541668.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(62541668)==0 and Duel.IsExistingMatchingCard(c62541668.rmfil,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c62541668.rmfil,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c62541668.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c62541668.rmfil,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		local og=Duel.GetOperatedGroup():Filter(Card.IsLocation,nil,LOCATION_REMOVED)
		if og:GetCount()>0 then
			local oc=og:Select(tp,1,1,nil)
			Duel.Overlay(e:GetHandler(),oc)
		end
	end
end

function c62541668.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(62541668,2)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end