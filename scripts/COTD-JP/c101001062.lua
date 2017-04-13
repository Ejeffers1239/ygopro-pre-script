--ルドラの魔導書
--Spellbook of Rudra
--Scripted by Eerie Code
function c101001062.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,101001062+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c101001062.target)
	e1:SetOperation(c101001062.activate)
	c:RegisterEffect(e1)
end
function c101001062.filter(c)
	return ((c:IsType(TYPE_MONSTER) and c:IsRace(RACE_SPELLCASTER) and c:IsLocation(LOCATION_MZONE)) 
		or (c:IsSetCard(0x106e) and not c:IsCode(101001062) )) 
		and c:IsAbleToGrave()
end
function c101001062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.IsExistingMatchingCard(c101001062.filter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c101001062.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c101001062.filter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end