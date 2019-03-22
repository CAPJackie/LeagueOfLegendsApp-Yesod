INSERT INTO public.champion(id, id_name, description, life, attackdamage, attackspeed, speed, regenerationlife, armor, magicresistence, rol)
VALUES (1, 'Aatrox', '580 (+80 por nivel)', '60 (+5 por nivel)', 'NaN (+2.5% por nivel)', '8 (+0.75 por nivel)', 345, '33 (+3.25 por nivel)', '32.1 (+1.25 por nivel)', '', 'Asesino'),
       (2, 'Akali','550 (+85 por nivel)', '62.4 (+3.3 por nivel)', 'NaN (+3.2% por nivel)', '6 (+0.5 por nivel)',345, '', '23 (+3.5 por nivel)', '32.1 (+1.25 por nivel)', 'Asesino');


INSERT INTO public.video(id, champion, name, url)
VALUES (1, 1, '5 things every pro Aatrox should know', 'https://www.youtube.com/watch?v=01RcyrBqj2w'),
       (2, 2, 'The ONLY Akali guide youll ever need', 'https://www.youtube.com/watch?v=JBBNPSaBjwM');


INSERT INTO public.equipment(id, name, cost, sell, passive, active, aura)
VALUES (1, 'B. F. Sword', '1300', '910', NULL, NULL, NULL),
       (2, 'Abyssal Mask', '3000', '2100', "UNIQUE ETERNITY: Restore mana equal to 15% of damage taken from champions. Restore health equal to 20% of mana spent, up to 25 health per cast, while toggle abilities can heal for up to 25 per second.", NULL, "UNIQUE: Nearby enemy champions take 15% more magic damage (325 range).");

