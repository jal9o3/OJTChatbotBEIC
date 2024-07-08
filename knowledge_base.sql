--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-08 09:44:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3364 (class 1262 OID 24752)
-- Name: knowledge_base; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE knowledge_base WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE knowledge_base OWNER TO postgres;

\connect knowledge_base

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24761)
-- Name: chunks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chunks (
    hash_string text NOT NULL,
    chunk text,
    chunk_order integer NOT NULL,
    paper_id character varying(255)
);


ALTER TABLE public.chunks OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24760)
-- Name: chunks_chunk_order_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chunks_chunk_order_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chunks_chunk_order_seq OWNER TO postgres;

--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 216
-- Name: chunks_chunk_order_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chunks_chunk_order_seq OWNED BY public.chunks.chunk_order;


--
-- TOC entry 215 (class 1259 OID 24753)
-- Name: paper_titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paper_titles (
    id character varying(255) NOT NULL,
    paper_title text,
    author_names text[],
    filename text,
    tags text[]
);


ALTER TABLE public.paper_titles OWNER TO postgres;

--
-- TOC entry 3207 (class 2604 OID 24764)
-- Name: chunks chunk_order; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chunks ALTER COLUMN chunk_order SET DEFAULT nextval('public.chunks_chunk_order_seq'::regclass);


--
-- TOC entry 3358 (class 0 OID 24761)
-- Dependencies: 217
-- Data for Name: chunks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chunks VALUES ('8586d553f4bc4b2fa13822c364b9b8a570cada87e2a1e9efb0e18ee99cb6577f', '﻿The Project Gutenberg eBook of The War of the Worlds
    
This ebook is for the use of anyone anywhere in the United States and
most other parts of the world at no cost and with almost no restrictions
whatsoever. You may copy it, give it away or re-use it under the terms
of the Project Gutenberg License included with this ebook or online
at www.gutenberg.org. If you are not located in the United States,
you will have to check the laws of the country where you are located
before using this eBook.', 0, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e1521b443aec2a64240f87193a4ddae9b7d55709b8669c6a44651a8ea5307453', 'Title: The War of the Worlds', 1, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f49fcc6d65092d992406fe1211d73a3b4ee7471febb2a160d4d0ae4b0240d044', 'Author: H. G. Wells', 2, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a2f51c364669b40c0640b11b1c6a26318137ea26069b29fd64c59c30bfc5b392', 'Release date: October 1, 2004 [eBook #36]
                Most recently updated: November 27, 2021', 3, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('022a66183dab94a88b4fbf049314d5038e987d132ea838d376dc4ac3c72b64dd', 'Language: English', 4, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4cf75a3cddb2006b767affdf2816cb12eeff629d99c4aacd1e923015dad96866', '', 5, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6c8014cda1bc7e6eab5a5d7ff1344bce8e1abbdc022691c91ae17b5f4b85f887', '*** START OF THE PROJECT GUTENBERG EBOOK THE WAR OF THE WORLDS ***', 6, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d197e8d10a15074507e0f150e96bb37f605874c9a0e3786f7338237e701b0753', 'cover ', 7, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1d804a65c78710eb13601705664714e63785f81778518d2172ba340971f308ad', '', 8, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8248ae6525338dbcc49d49b1d64a4a3f386d537a45c54066a2fb79e023b34094', '
The War of the Worlds', 9, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ee6d5c5db6fa4e40218025c3434bcd598fed5e1b65c2b60d3c60a4e96a858f68', 'by H. G. Wells', 10, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bed5cf864aeeb9306e69e23f14a28524c79d6d68d7a220f6171506d77f598368', '', 11, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('03aa955e5ae327d917788145a8d4469bb69b3a00809d5f74b00f6963eda26ba6', '
   ‘But who shall dwell in these worlds if they be inhabited?
    . . . Are we or they Lords of the World? . . . And
    how are all things made for man?’
                    KEPLER (quoted in _The Anatomy of Melancholy_)', 12, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('704b83406e5d57d6bb8bb55411864be54c11250917fded379a56f3beb6675d86', '', 13, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b689b836e95074a0dd5061feeb95b1d1e1908483706e23524b181ef9acbbf214', '
Contents', 14, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('16e4e7ad246a33f090a28377982bccaf3d9b5b0f70186325d3c2107ae55c4583', '
 BOOK ONE.—THE COMING OF THE MARTIANS', 15, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8dd27f9502c3e6e2cb7bc19df2a46c1f1f6bf884b48fc242af685217560dc8a9', ' I. THE EVE OF THE WAR.
 II. THE FALLING STAR.
 III. ON HORSELL COMMON.
 IV. THE CYLINDER OPENS.
 V. THE HEAT-RAY.
 VI. THE HEAT-RAY IN THE CHOBHAM ROAD.
 VII. HOW I REACHED HOME.
 VIII. FRIDAY NIGHT.
 IX. THE FIGHTING BEGINS.
 X. IN THE STORM.
 XI. AT THE WINDOW.
 XII. WHAT I SAW OF THE DESTRUCTION OF WEYBRIDGE AND SHEPPERTON.
 XIII. HOW I FELL IN WITH THE CURATE.
 XIV. IN LONDON.
 XV. WHAT HAD HAPPENED IN SURREY.
 XVI. THE EXODUS FROM LONDON.
 XVII. THE “THUNDER CHILD”.', 16, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8c900a6ebc5fc574cae0e0c3e01105de8d1862834b263560a5f6b849f89eb6bb', ' BOOK TWO.—THE EARTH UNDER THE MARTIANS', 17, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0ea8d8f6237539ad672c7903d294864e82c3b87c08425133081b31221ca17a24', ' I. UNDER FOOT.
 II. WHAT WE SAW FROM THE RUINED HOUSE.
 III. THE DAYS OF IMPRISONMENT.
 IV. THE DEATH OF THE CURATE.
 V. THE STILLNESS.
 VI. THE WORK OF FIFTEEN DAYS.
 VII. THE MAN ON PUTNEY HILL.
 VIII. DEAD LONDON.
 IX. WRECKAGE.
 X. THE EPILOGUE.', 18, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ea49d2b12b44c2de57a9195dc0af12c3e216dea671c196f6d271e27950069a1c', '', 19, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a723bdfb832b5a7d03ca69339ff6f00def14844baf7f754cdfe60692e4907619', '
BOOK ONE
THE COMING OF THE MARTIANS', 20, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6ad9372c66fc8e795da399081eeef2f1648b8b3b87b39742cfb8817a6879fe0b', '', 21, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('68a2dcf0bcdb982a3339fca5f683ec729c1ac54a1adc8efb47f83f97c63c1b52', '
I.
THE EVE OF THE WAR.', 22, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('140af1d63208f4f338bd39e022f154b1fa5d66ddac8cd0a5384a00dc956a5c41', '
No one would have believed in the last years of the nineteenth century
that this world was being watched keenly and closely by intelligences
greater than man’s and yet as mortal as his own; that as men busied
themselves about their various concerns they were scrutinised and
studied, perhaps almost as narrowly as a man with a microscope might
scrutinise the transient creatures that swarm and multiply in a drop of
water. With infinite complacency men went to and fro over this globe
about their little affairs, serene in their assurance of their empire
over matter. It is possible that the infusoria under the microscope do
the same. No one gave a thought to the older worlds of space as sources
of human danger, or thought of them only to dismiss the idea of life
upon them as impossible or improbable. It is curious to recall some of
the mental habits of those departed days. At most terrestrial men
fancied there might be other men upon Mars, perhaps inferior to
themselves and ready to welcome a missionary enterprise. Yet across the
gulf of space, minds that are to our minds as ours are to those of the
beasts that perish, intellects vast and cool and unsympathetic,
regarded this earth with envious eyes, and slowly and surely drew their
plans against us. And early in the twentieth century came the great
disillusionment.', 23, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5e394679126925e290eb0aaca1e4276686db3e0472549b7de4e4eb8eda63aa4a', 'The planet Mars, I scarcely need remind the reader, revolves about the
sun at a mean distance of 140,000,000 miles, and the light and heat it
receives from the sun is barely half of that received by this world. It
must be, if the nebular hypothesis has any truth, older than our world;
and long before this earth ceased to be molten, life upon its surface
must have begun its course. The fact that it is scarcely one seventh of
the volume of the earth must have accelerated its cooling to the
temperature at which life could begin. It has air and water and all
that is necessary for the support of animated existence.', 24, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e33ccdf2b1ac1c52904f9ad5693189b049b1104dac915be46a65e8db9c5d6033', 'Yet so vain is man, and so blinded by his vanity, that no writer, up to
the very end of the nineteenth century, expressed any idea that
intelligent life might have developed there far, or indeed at all,
beyond its earthly level. Nor was it generally understood that since
Mars is older than our earth, with scarcely a quarter of the
superficial area and remoter from the sun, it necessarily follows that
it is not only more distant from time’s beginning but nearer its end.', 25, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4952445ff9c6e984104798b9242abdf54eae0d54a48260673d5cb351eccde12', 'The secular cooling that must someday overtake our planet has already
gone far indeed with our neighbour. Its physical condition is still
largely a mystery, but we know now that even in its equatorial region
the midday temperature barely approaches that of our coldest winter.
Its air is much more attenuated than ours, its oceans have shrunk until
they cover but a third of its surface, and as its slow seasons change
huge snowcaps gather and melt about either pole and periodically
inundate its temperate zones. That last stage of exhaustion, which to
us is still incredibly remote, has become a present-day problem for the
inhabitants of Mars. The immediate pressure of necessity has brightened
their intellects, enlarged their powers, and hardened their hearts. And
looking across space with instruments, and intelligences such as we
have scarcely dreamed of, they see, at its nearest distance only
35,000,000 of miles sunward of them, a morning star of hope, our own
warmer planet, green with vegetation and grey with water, with a cloudy
atmosphere eloquent of fertility, with glimpses through its drifting
cloud wisps of broad stretches of populous country and narrow,
navy-crowded seas.', 26, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('29c0cb3f5f851e4dbd7599fa387f30ed33f03ba6d7f9a11c942f5a4229561b08', 'And we men, the creatures who inhabit this earth, must be to them at
least as alien and lowly as are the monkeys and lemurs to us. The
intellectual side of man already admits that life is an incessant
struggle for existence, and it would seem that this too is the belief
of the minds upon Mars. Their world is far gone in its cooling and this
world is still crowded with life, but crowded only with what they
regard as inferior animals. To carry warfare sunward is, indeed, their
only escape from the destruction that, generation after generation,
creeps upon them.', 27, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('363f73fea87d869962823f7e8f18cb6fd1ba2bcb7205ac7d17b27f1d19779a64', 'And before we judge of them too harshly we must remember what ruthless
and utter destruction our own species has wrought, not only upon
animals, such as the vanished bison and the dodo, but upon its inferior
races. The Tasmanians, in spite of their human likeness, were entirely
swept out of existence in a war of extermination waged by European
immigrants, in the space of fifty years. Are we such apostles of mercy
as to complain if the Martians warred in the same spirit?', 28, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b4d4dd93e06ef06e5eee09cd9034b18f2066249c001072e515925da0ed06b65a', 'The Martians seem to have calculated their descent with amazing
subtlety—their mathematical learning is evidently far in excess of
ours—and to have carried out their preparations with a well-nigh
perfect unanimity. Had our instruments permitted it, we might have seen
the gathering trouble far back in the nineteenth century. Men like
Schiaparelli watched the red planet—it is odd, by-the-bye, that for
countless centuries Mars has been the star of war—but failed to
interpret the fluctuating appearances of the markings they mapped so
well. All that time the Martians must have been getting ready.', 29, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a19d5322b6f7ada42fc75cc928da4fa78c580908e9b4aa1ad86949af27b6bb48', 'During the opposition of 1894 a great light was seen on the illuminated
part of the disk, first at the Lick Observatory, then by Perrotin of
Nice, and then by other observers. English readers heard of it first in
the issue of _Nature_ dated August 2. I am inclined to think that this
blaze may have been the casting of the huge gun, in the vast pit sunk
into their planet, from which their shots were fired at us. Peculiar
markings, as yet unexplained, were seen near the site of that outbreak
during the next two oppositions.', 30, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a6683d2cdf335bdc50cf4deb5095b3db38109518fbcbfeae4edee1346996075b', 'The storm burst upon us six years ago now. As Mars approached
opposition, Lavelle of Java set the wires of the astronomical exchange
palpitating with the amazing intelligence of a huge outbreak of
incandescent gas upon the planet. It had occurred towards midnight of
the twelfth; and the spectroscope, to which he had at once resorted,
indicated a mass of flaming gas, chiefly hydrogen, moving with an
enormous velocity towards this earth. This jet of fire had become
invisible about a quarter past twelve. He compared it to a colossal
puff of flame suddenly and violently squirted out of the planet, “as
flaming gases rushed out of a gun.”', 31, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6df268019cb6d56f7b4f8a7126e70dec40410ca5c9dde45d1f756547d4b2ae0b', 'A singularly appropriate phrase it proved. Yet the next day there was
nothing of this in the papers except a little note in the _Daily
Telegraph_, and the world went in ignorance of one of the gravest
dangers that ever threatened the human race. I might not have heard of
the eruption at all had I not met Ogilvy, the well-known astronomer, at
Ottershaw. He was immensely excited at the news, and in the excess of
his feelings invited me up to take a turn with him that night in a
scrutiny of the red planet.', 32, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cc2c190cbecd1c15bcb78a5e4f20e55d3ae9309bc21352ac1b866de264530db9', 'In spite of all that has happened since, I still remember that vigil
very distinctly: the black and silent observatory, the shadowed lantern
throwing a feeble glow upon the floor in the corner, the steady ticking
of the clockwork of the telescope, the little slit in the roof—an
oblong profundity with the stardust streaked across it. Ogilvy moved
about, invisible but audible. Looking through the telescope, one saw a
circle of deep blue and the little round planet swimming in the field.
It seemed such a little thing, so bright and small and still, faintly
marked with transverse stripes, and slightly flattened from the perfect
round. But so little it was, so silvery warm—a pin’s head of light! It
was as if it quivered, but really this was the telescope vibrating with
the activity of the clockwork that kept the planet in view.', 33, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f9cf39bf26b0ba7d2b8fac40af2ceacd923a7a004ac90213dc62b543d1d9a6dc', 'As I watched, the planet seemed to grow larger and smaller and to
advance and recede, but that was simply that my eye was tired. Forty
millions of miles it was from us—more than forty millions of miles of
void. Few people realise the immensity of vacancy in which the dust of
the material universe swims.', 34, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3517ef9c7f642ce0d50d31fc5e2c49263f8e17f97e6facb4fd996600ed3d75d6', '“Here they are!” shouted a man in a blue jersey. “Yonder! D’yer see
them? Yonder!”', 353, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fc2c63a593820dece6dc8487c8a9f3170c9a7cc986a462159212f2b669a3d93f', 'Near it in the field, I remember, were three faint points of light,
three telescopic stars infinitely remote, and all around it was the
unfathomable darkness of empty space. You know how that blackness looks
on a frosty starlight night. In a telescope it seems far profounder.
And invisible to me because it was so remote and small, flying swiftly
and steadily towards me across that incredible distance, drawing nearer
every minute by so many thousands of miles, came the Thing they were
sending us, the Thing that was to bring so much struggle and calamity
and death to the earth. I never dreamed of it then as I watched; no one
on earth dreamed of that unerring missile.', 35, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5d2fe54b6aaa6cbe62147bf3e661a584370af609f8c2bd2d582995c35e20cde8', 'That night, too, there was another jetting out of gas from the distant
planet. I saw it. A reddish flash at the edge, the slightest projection
of the outline just as the chronometer struck midnight; and at that I
told Ogilvy and he took my place. The night was warm and I was thirsty,
and I went stretching my legs clumsily and feeling my way in the
darkness, to the little table where the siphon stood, while Ogilvy
exclaimed at the streamer of gas that came out towards us.', 36, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b0b67ad03676468f1032c87bcd52b926a8333c1e846d5b3201c19264a8bd315d', 'That night another invisible missile started on its way to the earth
from Mars, just a second or so under twenty-four hours after the first
one. I remember how I sat on the table there in the blackness, with
patches of green and crimson swimming before my eyes. I wished I had a
light to smoke by, little suspecting the meaning of the minute gleam I
had seen and all that it would presently bring me. Ogilvy watched till
one, and then gave it up; and we lit the lantern and walked over to his
house. Down below in the darkness were Ottershaw and Chertsey and all
their hundreds of people, sleeping in peace.', 37, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bfbc93184422c9a54bec43ed1191c6bea1e808d72f079a45006e38aeb2c8226e', 'He was full of speculation that night about the condition of Mars, and
scoffed at the vulgar idea of its having inhabitants who were
signalling us. His idea was that meteorites might be falling in a heavy
shower upon the planet, or that a huge volcanic explosion was in
progress. He pointed out to me how unlikely it was that organic
evolution had taken the same direction in the two adjacent planets.', 38, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('25beda04c1999568fed580f441be87acb99dfdc13f933a5e691c5da12725cce0', '“The chances against anything manlike on Mars are a million to one,” he
said.', 39, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('26fad5052fe5606e80b7595e78fc2689289f20dced9ad5152b7b7e6aea0bf159', 'Hundreds of observers saw the flame that night and the night after
about midnight, and again the night after; and so for ten nights, a
flame each night. Why the shots ceased after the tenth no one on earth
has attempted to explain. It may be the gases of the firing caused the
Martians inconvenience. Dense clouds of smoke or dust, visible through
a powerful telescope on earth as little grey, fluctuating patches,
spread through the clearness of the planet’s atmosphere and obscured
its more familiar features.', 40, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6630c7236581b26f48aa3fd6e60fb5c01dc3cc37a8d67ec9c58caf5f8fbe8ef2', 'Even the daily papers woke up to the disturbances at last, and popular
notes appeared here, there, and everywhere concerning the volcanoes
upon Mars. The seriocomic periodical _Punch_, I remember, made a happy
use of it in the political cartoon. And, all unsuspected, those
missiles the Martians had fired at us drew earthward, rushing now at a
pace of many miles a second through the empty gulf of space, hour by
hour and day by day, nearer and nearer. It seems to me now almost
incredibly wonderful that, with that swift fate hanging over us, men
could go about their petty concerns as they did. I remember how
jubilant Markham was at securing a new photograph of the planet for the
illustrated paper he edited in those days. People in these latter times
scarcely realise the abundance and enterprise of our nineteenth-century
papers. For my own part, I was much occupied in learning to ride the
bicycle, and busy upon a series of papers discussing the probable
developments of moral ideas as civilisation progressed.', 41, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0f2caf9af787331265568d77d9d75ec7974b22d267b00a44ad9328d108b444e1', 'One night (the first missile then could scarcely have been 10,000,000
miles away) I went for a walk with my wife. It was starlight and I
explained the Signs of the Zodiac to her, and pointed out Mars, a
bright dot of light creeping zenithward, towards which so many
telescopes were pointed. It was a warm night. Coming home, a party of
excursionists from Chertsey or Isleworth passed us singing and playing
music. There were lights in the upper windows of the houses as the
people went to bed. From the railway station in the distance came the
sound of shunting trains, ringing and rumbling, softened almost into
melody by the distance. My wife pointed out to me the brightness of the
red, green, and yellow signal lights hanging in a framework against the
sky. It seemed so safe and tranquil.', 42, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f05abc2e6d3bf9c7c156360c9cf6d3cfd003e6ee52d9f38b05eecfcaae45fc30', '', 43, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d69983f93e2756793cfcf361e6919c7cf9443736ef78c116d70effe289a7bafd', '
II.
THE FALLING STAR.', 44, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f37e54f8a4da07593c25ddc01e6f34b64f5d97baf7d197eca0f177b5ab79dcef', '
Then came the night of the first falling star. It was seen early in the
morning, rushing over Winchester eastward, a line of flame high in the
atmosphere. Hundreds must have seen it, and taken it for an ordinary
falling star. Albin described it as leaving a greenish streak behind it
that glowed for some seconds. Denning, our greatest authority on
meteorites, stated that the height of its first appearance was about
ninety or one hundred miles. It seemed to him that it fell to earth
about one hundred miles east of him.', 45, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d21fdcc8402dba9116e641f42aca00bf8ca50966d01b8f162f0988f92e3deba', 'I was at home at that hour and writing in my study; and although my
French windows face towards Ottershaw and the blind was up (for I loved
in those days to look up at the night sky), I saw nothing of it. Yet
this strangest of all things that ever came to earth from outer space
must have fallen while I was sitting there, visible to me had I only
looked up as it passed. Some of those who saw its flight say it
travelled with a hissing sound. I myself heard nothing of that. Many
people in Berkshire, Surrey, and Middlesex must have seen the fall of
it, and, at most, have thought that another meteorite had descended. No
one seems to have troubled to look for the fallen mass that night.', 46, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c907a35055108e2c7552083abec3f42a7251619beaabc399ffe195328ea504a1', 'He relapsed into silence, with his chin now sunken almost to his knees.', 399, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bb751f551fa78ac6e1c72a036937b6d3132343a44ee7abfede9da183d4e51c99', 'But very early in the morning poor Ogilvy, who had seen the shooting
star and who was persuaded that a meteorite lay somewhere on the common
between Horsell, Ottershaw, and Woking, rose early with the idea of
finding it. Find it he did, soon after dawn, and not far from the
sand-pits. An enormous hole had been made by the impact of the
projectile, and the sand and gravel had been flung violently in every
direction over the heath, forming heaps visible a mile and a half away.
The heather was on fire eastward, and a thin blue smoke rose against
the dawn.', 47, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f93b6d4cc43b79b55d85a03568382c646acdc589c969b673c38af920a0bef28b', 'The Thing itself lay almost entirely buried in sand, amidst the
scattered splinters of a fir tree it had shivered to fragments in its
descent. The uncovered part had the appearance of a huge cylinder,
caked over and its outline softened by a thick scaly dun-coloured
incrustation. It had a diameter of about thirty yards. He approached
the mass, surprised at the size and more so at the shape, since most
meteorites are rounded more or less completely. It was, however, still
so hot from its flight through the air as to forbid his near approach.
A stirring noise within its cylinder he ascribed to the unequal cooling
of its surface; for at that time it had not occurred to him that it
might be hollow.', 48, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('99eb5600dd4f41b775ed359de0d736c3eaf29bccd6aaf5d9846447cf56af8ed8', 'He remained standing at the edge of the pit that the Thing had made for
itself, staring at its strange appearance, astonished chiefly at its
unusual shape and colour, and dimly perceiving even then some evidence
of design in its arrival. The early morning was wonderfully still, and
the sun, just clearing the pine trees towards Weybridge, was already
warm. He did not remember hearing any birds that morning, there was
certainly no breeze stirring, and the only sounds were the faint
movements from within the cindery cylinder. He was all alone on the
common.', 49, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('15e60ecb5cbc71984ba9de1f91ef1efcd503fd329703fdbbb5a6d06af5c8dff7', 'Then suddenly he noticed with a start that some of the grey clinker,
the ashy incrustation that covered the meteorite, was falling off the
circular edge of the end. It was dropping off in flakes and raining
down upon the sand. A large piece suddenly came off and fell with a
sharp noise that brought his heart into his mouth.', 50, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('66bef4614a83b3d3a86f82ff5c8809e46d5c1b8411018391f3bb491aa4c7de09', 'For a minute he scarcely realised what this meant, and, although the
heat was excessive, he clambered down into the pit close to the bulk to
see the Thing more clearly. He fancied even then that the cooling of
the body might account for this, but what disturbed that idea was the
fact that the ash was falling only from the end of the cylinder.', 51, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d877c9230b33b821a361ed3464a9ffd493ccb75868ae41eddb5dd659a8a93c03', 'And then he perceived that, very slowly, the circular top of the
cylinder was rotating on its body. It was such a gradual movement that
he discovered it only through noticing that a black mark that had been
near him five minutes ago was now at the other side of the
circumference. Even then he scarcely understood what this indicated,
until he heard a muffled grating sound and saw the black mark jerk
forward an inch or so. Then the thing came upon him in a flash. The
cylinder was artificial—hollow—with an end that screwed out! Something
within the cylinder was unscrewing the top!', 52, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('65773d75278f56fd1643d770b96764a4611c71bae39404a89c5f842a7e1a1fe6', '“Good heavens!” said Ogilvy. “There’s a man in it—men in it! Half
roasted to death! Trying to escape!”', 53, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f6da35dddb625f023d2ffcd1a69b95c4705651790f41a0ec3a463058a649812c', 'At once, with a quick mental leap, he linked the Thing with the flash
upon Mars.', 54, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1880df2c19732b45e5f6164dc60dd3978eb1537eb554059585ce56dd7d3c4a3e', 'The thought of the confined creature was so dreadful to him that he
forgot the heat and went forward to the cylinder to help turn. But
luckily the dull radiation arrested him before he could burn his hands
on the still-glowing metal. At that he stood irresolute for a moment,
then turned, scrambled out of the pit, and set off running wildly into
Woking. The time then must have been somewhere about six o’clock. He
met a waggoner and tried to make him understand, but the tale he told
and his appearance were so wild—his hat had fallen off in the pit—that
the man simply drove on. He was equally unsuccessful with the potman
who was just unlocking the doors of the public-house by Horsell Bridge.
The fellow thought he was a lunatic at large and made an unsuccessful
attempt to shut him into the taproom. That sobered him a little; and
when he saw Henderson, the London journalist, in his garden, he called
over the palings and made himself understood.', 55, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7821831cb9be93de5c86e68f427c92cfaa2776860979702a27cb7ed12dcf39bf', '“Henderson,” he called, “you saw that shooting star last night?”', 56, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e421e903dc58843b95ac6b62ac20cb0b276c9f10d0a3beca45b32e3c2cc46789', '“Well?” said Henderson.', 57, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('78602749a47bef73fe17af2795b453bcd0ec32cf1046175a1e18d18b47c4bfdd', '“It’s out on Horsell Common now.”', 58, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c38b9133572e43f1c0c3fc0a53ac4a41a52d24cb5ecfa2b467a8b0561213c051', '“Good Lord!” said Henderson. “Fallen meteorite! That’s good.”', 59, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4a2cdbd3e7a735648f2230249e110e269e4a19e7231aceae7092263733b13f1', '“But it’s something more than a meteorite. It’s a cylinder—an
artificial cylinder, man! And there’s something inside.”', 60, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1b473c13874dcc8712126ab08c372ee3f9e1eaf89ad4c23082ba10953a3a44fa', 'Henderson stood up with his spade in his hand.', 61, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c0c23416ae469057590f6d8a37fb5b6c8368a55c0e3dd00eaab62cf61697cf68', '“What’s that?” he said. He was deaf in one ear.', 62, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4c392bb1476c27031ce64b48e05f42549bf9533cf7dcc8eebc1af2e038320089', 'Ogilvy told him all that he had seen. Henderson was a minute or so
taking it in. Then he dropped his spade, snatched up his jacket, and
came out into the road. The two men hurried back at once to the common,
and found the cylinder still lying in the same position. But now the
sounds inside had ceased, and a thin circle of bright metal showed
between the top and the body of the cylinder. Air was either entering
or escaping at the rim with a thin, sizzling sound.', 63, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d888fb35ff1f09aa794e68a968ab205b777fccba1258dd552759035a2c5cf9b1', 'They listened, rapped on the scaly burnt metal with a stick, and,
meeting with no response, they both concluded the man or men inside
must be insensible or dead.', 64, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d699f27add559f0dd13e1f9de69e7200423c350bfdce0931a52b47af4c229f6', 'Of course the two were quite unable to do anything. They shouted
consolation and promises, and went off back to the town again to get
help. One can imagine them, covered with sand, excited and disordered,
running up the little street in the bright sunlight just as the shop
folks were taking down their shutters and people were opening their
bedroom windows. Henderson went into the railway station at once, in
order to telegraph the news to London. The newspaper articles had
prepared men’s minds for the reception of the idea.', 65, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5de3236572cbd97c7e017517d32a66db8f51fd73e500fa883c06a5978a276337', 'By eight o’clock a number of boys and unemployed men had already
started for the common to see the “dead men from Mars.” That was the
form the story took. I heard of it first from my newspaper boy about a
quarter to nine when I went out to get my _Daily Chronicle_. I was
naturally startled, and lost no time in going out and across the
Ottershaw bridge to the sand-pits.', 66, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('00cb38e13384591e919e9d0804bf5bc463813fef7e4b65d5f5d752b523a652fa', '', 67, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('59879508b5d9a3d9ce419603b770601b54cbc48e6b662acc395856acd67655bb', '
III.
ON HORSELL COMMON.', 68, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('92d2bc49f187c359d404a05707970108b1765d9f912ebe327dd1a72c92badf5f', '
I found a little crowd of perhaps twenty people surrounding the huge
hole in which the cylinder lay. I have already described the appearance
of that colossal bulk, embedded in the ground. The turf and gravel
about it seemed charred as if by a sudden explosion. No doubt its
impact had caused a flash of fire. Henderson and Ogilvy were not there.
I think they perceived that nothing was to be done for the present, and
had gone away to breakfast at Henderson’s house.', 69, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('240607111c376225529ac8b2c7ace2c8c0a4453448a991331ca0caf0a17cb5bf', 'There were four or five boys sitting on the edge of the Pit, with their
feet dangling, and amusing themselves—until I stopped them—by throwing
stones at the giant mass. After I had spoken to them about it, they
began playing at “touch” in and out of the group of bystanders.', 70, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e3f1060b4def883caa216b298cea6564efec837555d3d9450ef38ad8a3d10fc0', 'Among these were a couple of cyclists, a jobbing gardener I employed
sometimes, a girl carrying a baby, Gregg the butcher and his little
boy, and two or three loafers and golf caddies who were accustomed to
hang about the railway station. There was very little talking. Few of
the common people in England had anything but the vaguest astronomical
ideas in those days. Most of them were staring quietly at the big table
like end of the cylinder, which was still as Ogilvy and Henderson had
left it. I fancy the popular expectation of a heap of charred corpses
was disappointed at this inanimate bulk. Some went away while I was
there, and other people came. I clambered into the pit and fancied I
heard a faint movement under my feet. The top had certainly ceased to
rotate.', 71, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('85da56d8d8e42c681c9f5b6274b9fe7b702fd881ca58372e554cb9bf96c2ddfb', 'It was only when I got thus close to it that the strangeness of this
object was at all evident to me. At the first glance it was really no
more exciting than an overturned carriage or a tree blown across the
road. Not so much so, indeed. It looked like a rusty gas float. It
required a certain amount of scientific education to perceive that the
grey scale of the Thing was no common oxide, that the yellowish-white
metal that gleamed in the crack between the lid and the cylinder had an
unfamiliar hue. “Extra-terrestrial” had no meaning for most of the
onlookers.', 72, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eb27bbe42240ba57598609f3c02ac20e48674d909a07595b881f830f2e8e06fc', 'At that time it was quite clear in my own mind that the Thing had come
from the planet Mars, but I judged it improbable that it contained any
living creature. I thought the unscrewing might be automatic. In spite
of Ogilvy, I still believed that there were men in Mars. My mind ran
fancifully on the possibilities of its containing manuscript, on the
difficulties in translation that might arise, whether we should find
coins and models in it, and so forth. Yet it was a little too large for
assurance on this idea. I felt an impatience to see it opened. About
eleven, as nothing seemed happening, I walked back, full of such
thought, to my home in Maybury. But I found it difficult to get to work
upon my abstract investigations.', 73, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5358f616ab57026fc955f516d0f7f2f8316ab04a62f0efcca3acde990db6c59f', 'In the afternoon the appearance of the common had altered very much.
The early editions of the evening papers had startled London with
enormous headlines:', 74, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8d76d4f99af748da2ab19c642845fde45ad6272b0bc8032355de7f4e103eedb3', '“A MESSAGE RECEIVED FROM MARS.”', 75, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8aa93a9c68d609b7fd0deeb9b208e24c8f139f944280916dceffcbb2f7257163', '
“REMARKABLE STORY FROM WOKING,”', 76, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dc8b23153022e1aa1f73f9aabb8da22832f106ebc875727b6e3b4c1e5cde0d96', '
and so forth. In addition, Ogilvy’s wire to the Astronomical Exchange
had roused every observatory in the three kingdoms.', 77, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9fb9567dce90fff013c2acdccb162ec3af537a7093e93799aa2684f0efb5333a', 'There were half a dozen flys or more from the Woking station standing
in the road by the sand-pits, a basket-chaise from Chobham, and a
rather lordly carriage. Besides that, there was quite a heap of
bicycles. In addition, a large number of people must have walked, in
spite of the heat of the day, from Woking and Chertsey, so that there
was altogether quite a considerable crowd—one or two gaily dressed
ladies among the others.', 78, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b72be205c27877c15dbd68321092c05086b7782cd35c4e4e6ec8c864da6b0680', 'It was glaringly hot, not a cloud in the sky nor a breath of wind, and
the only shadow was that of the few scattered pine trees. The burning
heather had been extinguished, but the level ground towards Ottershaw
was blackened as far as one could see, and still giving off vertical
streamers of smoke. An enterprising sweet-stuff dealer in the Chobham
Road had sent up his son with a barrow-load of green apples and ginger
beer.', 79, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5853ca631d56220d970d7e66b4d786bd229b6a57dd3e0aa31364e2086df6f30e', 'Presently he began waving his hand.', 400, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3007d2fb4e68880f4dcbfbcde271ad19ffc5a96953af0ff52f3fb2434ddcf25e', 'Going to the edge of the pit, I found it occupied by a group of about
half a dozen men—Henderson, Ogilvy, and a tall, fair-haired man that I
afterwards learned was Stent, the Astronomer Royal, with several
workmen wielding spades and pickaxes. Stent was giving directions in a
clear, high-pitched voice. He was standing on the cylinder, which was
now evidently much cooler; his face was crimson and streaming with
perspiration, and something seemed to have irritated him.', 80, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('361f307958f1b475298ba9e147bad283bf9239e9ff45cbc919e480075616b5d9', 'A large portion of the cylinder had been uncovered, though its lower
end was still embedded. As soon as Ogilvy saw me among the staring
crowd on the edge of the pit he called to me to come down, and asked me
if I would mind going over to see Lord Hilton, the lord of the manor.', 81, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ad29c4ac7463c7d47e989dda1fbc2d0cba40fbe4a6be1ca42dce889110bc3fae', 'The growing crowd, he said, was becoming a serious impediment to their
excavations, especially the boys. They wanted a light railing put up,
and help to keep the people back. He told me that a faint stirring was
occasionally still audible within the case, but that the workmen had
failed to unscrew the top, as it afforded no grip to them. The case
appeared to be enormously thick, and it was possible that the faint
sounds we heard represented a noisy tumult in the interior.', 82, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e0bdcae7a95718c7e0370db90312346750fde771510caafda310e92a1b358b85', 'I was very glad to do as he asked, and so become one of the privileged
spectators within the contemplated enclosure. I failed to find Lord
Hilton at his house, but I was told he was expected from London by the
six o’clock train from Waterloo; and as it was then about a quarter
past five, I went home, had some tea, and walked up to the station to
waylay him.', 83, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bb8de73a41e56a1bb243a7f1affcb6110fb6792d138e87c40b9d04071a13e568', '', 84, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dfb4cdf7bdb0230da30a0fe14a5173e0a80b70925ca49d620a72dd87668445a0', '
IV.
THE CYLINDER OPENS.', 85, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('39f6e1c0106f310511290890093d84c42c22f1c9dc1c830406ba884880fd9683', '
When I returned to the common the sun was setting. Scattered groups
were hurrying from the direction of Woking, and one or two persons were
returning. The crowd about the pit had increased, and stood out black
against the lemon yellow of the sky—a couple of hundred people,
perhaps. There were raised voices, and some sort of struggle appeared
to be going on about the pit. Strange imaginings passed through my
mind. As I drew nearer I heard Stent’s voice:', 86, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8f199114b1822f09b2a9ad9bcc812aec41173346e5554f7e8215953027b4f1c3', '“Keep back! Keep back!”', 87, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dec00a22de745f3bd71898c9d6ba0e89669bc8a04bd0f957190da0ad3f157800', 'A boy came running towards me.', 88, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c3dc9eda207f5f3bb0970dc1883fc9053f6e853a91dc84cadbef1e189429c3e8', '“It’s a-movin’,” he said to me as he passed; “a-screwin’ and a-screwin’
out. I don’t like it. I’m a-goin’ ’ome, I am.”', 89, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('190ce8bc7726b4190935c24dcff9c2cc30efd35d9a02a36dee21f50bf3b0bbdc', 'I went on to the crowd. There were really, I should think, two or three
hundred people elbowing and jostling one another, the one or two ladies
there being by no means the least active.', 90, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('477da31236e12cc3e25427232e17ef45163833c91d62ff9591ebf5a20a7d1391', '“He’s fallen in the pit!” cried some one.', 91, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('380980b2c9771b3c0b8565953733d7c13b651ed6964717e8b1a62f1ac3009858', '“Keep back!” said several.', 92, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dc56eac2e353e0474dca96cd4e79b5db75182467fb86a13118d3725e9a6941f8', 'The crowd swayed a little, and I elbowed my way through. Every one
seemed greatly excited. I heard a peculiar humming sound from the pit.', 93, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('787dc020876109ff1fd77b964504cf891e98e06d0408e6cb7df38e0137730d88', '“I say!” said Ogilvy; “help keep these idiots back. We don’t know
what’s in the confounded thing, you know!”', 94, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9acc278e332109b8a7c4d39519aed716f4bebdd0dff4c33310e2aee1370f0549', 'I saw a young man, a shop assistant in Woking I believe he was,
standing on the cylinder and trying to scramble out of the hole again.
The crowd had pushed him in.', 95, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1eb9eaf05471e2297b4328827278b1b814235f04038242cbb6bb6a09d68ef211', 'The end of the cylinder was being screwed out from within. Nearly two
feet of shining screw projected. Somebody blundered against me, and I
narrowly missed being pitched onto the top of the screw. I turned, and
as I did so the screw must have come out, for the lid of the cylinder
fell upon the gravel with a ringing concussion. I stuck my elbow into
the person behind me, and turned my head towards the Thing again. For a
moment that circular cavity seemed perfectly black. I had the sunset in
my eyes.', 96, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c352b233dd534d3784be23e4339b3a9f887c0cd8052aed925e95d02ccdd28532', 'I think everyone expected to see a man emerge—possibly something a
little unlike us terrestrial men, but in all essentials a man. I know I
did. But, looking, I presently saw something stirring within the
shadow: greyish billowy movements, one above another, and then two
luminous disks—like eyes. Then something resembling a little grey
snake, about the thickness of a walking stick, coiled up out of the
writhing middle, and wriggled in the air towards me—and then another.', 97, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('afc11f013c95d52a37a8d0579a2e0d3b01a9e969e6721c2a72eac20db1d8b8fb', 'A sudden chill came over me. There was a loud shriek from a woman
behind. I half turned, keeping my eyes fixed upon the cylinder still,
from which other tentacles were now projecting, and began pushing my
way back from the edge of the pit. I saw astonishment giving place to
horror on the faces of the people about me. I heard inarticulate
exclamations on all sides. There was a general movement backwards. I
saw the shopman struggling still on the edge of the pit. I found myself
alone, and saw the people on the other side of the pit running off,
Stent among them. I looked again at the cylinder, and ungovernable
terror gripped me. I stood petrified and staring.', 98, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5b4c8ea07c60b027f66a894499d226f54fb4818d15bda39d5e387a3560f86158', '“The smoke of her burning goeth up for ever and ever!” he shouted.', 403, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('22a6aeec17289c4741f125eaa6a9f5f0304be7c9f70db2ad865d39270750fda2', 'A big greyish rounded bulk, the size, perhaps, of a bear, was rising
slowly and painfully out of the cylinder. As it bulged up and caught
the light, it glistened like wet leather.', 99, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2aa1a91854ceb3f84bdc0c52947d5c952f90d0c1bb57b11f3958ada9e69cd5a2', 'Two large dark-coloured eyes were regarding me steadfastly. The mass
that framed them, the head of the thing, was rounded, and had, one
might say, a face. There was a mouth under the eyes, the lipless brim
of which quivered and panted, and dropped saliva. The whole creature
heaved and pulsated convulsively. A lank tentacular appendage gripped
the edge of the cylinder, another swayed in the air.', 100, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e7d562bbec2460f4a03a5571bd8e07460c734d8b37b7b9a25f2ee23633161a1', 'Those who have never seen a living Martian can scarcely imagine the
strange horror of its appearance. The peculiar V-shaped mouth with its
pointed upper lip, the absence of brow ridges, the absence of a chin
beneath the wedgelike lower lip, the incessant quivering of this mouth,
the Gorgon groups of tentacles, the tumultuous breathing of the lungs
in a strange atmosphere, the evident heaviness and painfulness of
movement due to the greater gravitational energy of the earth—above
all, the extraordinary intensity of the immense eyes—were at once
vital, intense, inhuman, crippled and monstrous. There was something
fungoid in the oily brown skin, something in the clumsy deliberation of
the tedious movements unspeakably nasty. Even at this first encounter,
this first glimpse, I was overcome with disgust and dread.', 101, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4efbe89121ddf4f8e7fbfeb8d80b83d9542a6cad6109a2565bac237173cccf4f', 'Suddenly the monster vanished. It had toppled over the brim of the
cylinder and fallen into the pit, with a thud like the fall of a great
mass of leather. I heard it give a peculiar thick cry, and forthwith
another of these creatures appeared darkly in the deep shadow of the
aperture.', 102, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f2afc68e7072702aa3b2071013faa52e838c2b88f350c9c8a2f25f0a6a9df370', 'I turned and, running madly, made for the first group of trees, perhaps
a hundred yards away; but I ran slantingly and stumbling, for I could
not avert my face from these things.', 103, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('02fd32dfc9285ba8d40398cc124aeb2d3611c360d053f89427fbea246170d106', 'There, among some young pine trees and furze bushes, I stopped,
panting, and waited further developments. The common round the
sand-pits was dotted with people, standing like myself in a
half-fascinated terror, staring at these creatures, or rather at the
heaped gravel at the edge of the pit in which they lay. And then, with
a renewed horror, I saw a round, black object bobbing up and down on
the edge of the pit. It was the head of the shopman who had fallen in,
but showing as a little black object against the hot western sun. Now
he got his shoulder and knee up, and again he seemed to slip back until
only his head was visible. Suddenly he vanished, and I could have
fancied a faint shriek had reached me. I had a momentary impulse to go
back and help him that my fears overruled.', 104, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e9903a0a499c27592b5a10d730fbd7f76a44d761fb580b955e0aa3d03ccd7579', 'Everything was then quite invisible, hidden by the deep pit and the
heap of sand that the fall of the cylinder had made. Anyone coming
along the road from Chobham or Woking would have been amazed at the
sight—a dwindling multitude of perhaps a hundred people or more
standing in a great irregular circle, in ditches, behind bushes, behind
gates and hedges, saying little to one another and that in short,
excited shouts, and staring, staring hard at a few heaps of sand. The
barrow of ginger beer stood, a queer derelict, black against the
burning sky, and in the sand-pits was a row of deserted vehicles with
their horses feeding out of nosebags or pawing the ground.', 105, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bd2dda0a851880629baf20c15ec9dd6a1cde446c089030c028fd581683988d14', '', 106, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('aecfe90edd4ab7e5c2d743e1686134fd23f97773521bf5d0375b1e54ba64bb47', '
V.
THE HEAT-RAY.', 107, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1cbe286e8d065b44b4b1e0b091bb27b23738bcb549d50f4be5cc8acc9cf58f92', '
After the glimpse I had had of the Martians emerging from the cylinder
in which they had come to the earth from their planet, a kind of
fascination paralysed my actions. I remained standing knee-deep in the
heather, staring at the mound that hid them. I was a battleground of
fear and curiosity.', 108, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e7ec22e7c0daffc0859bc935dfa33fa6fce3e6d7f18309f55499a614c6c427ff', 'I did not dare to go back towards the pit, but I felt a passionate
longing to peer into it. I began walking, therefore, in a big curve,
seeking some point of vantage and continually looking at the sand-heaps
that hid these new-comers to our earth. Once a leash of thin black
whips, like the arms of an octopus, flashed across the sunset and was
immediately withdrawn, and afterwards a thin rod rose up, joint by
joint, bearing at its apex a circular disk that spun with a wobbling
motion. What could be going on there?', 109, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dcddaab2e9b8741cdcbc324a76b002a0b561e17645f9bab1ac988aaaa7289bc4', 'Most of the spectators had gathered in one or two groups—one a little
crowd towards Woking, the other a knot of people in the direction of
Chobham. Evidently they shared my mental conflict. There were few near
me. One man I approached—he was, I perceived, a neighbour of mine,
though I did not know his name—and accosted. But it was scarcely a time
for articulate conversation.', 110, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ddee6e3cd2b82914f698113ac04a509afa043ee1f3469162fc99cee288eada6f', '“What ugly _brutes_!” he said. “Good God! What ugly brutes!” He
repeated this over and over again.', 111, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ab85c6f75825a68634fc9fd488ccb3b4b630079bdb3e97a4e2aa26012847927f', '“Did you see a man in the pit?” I said; but he made no answer to that.
We became silent, and stood watching for a time side by side, deriving,
I fancy, a certain comfort in one another’s company. Then I shifted my
position to a little knoll that gave me the advantage of a yard or more
of elevation and when I looked for him presently he was walking towards
Woking.', 112, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('759cb2e6e3abc05cd6afc9aceff1b9a02acd08ae5df18f6a54b06db3b7895ee1', 'The sunset faded to twilight before anything further happened. The
crowd far away on the left, towards Woking, seemed to grow, and I heard
now a faint murmur from it. The little knot of people towards Chobham
dispersed. There was scarcely an intimation of movement from the pit.', 113, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e188124df809626c1dde8cb1d3a610490086ca0f0432ca28923eb0e4cdb511b', 'His eyes flamed, and he pointed a lean finger in the direction of
Weybridge.', 404, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('022a35d7f0a0c9eeca0f17781dedc71725fce5a2d24f6e8a03e30ae1f79ec366', 'It was this, as much as anything, that gave people courage, and I
suppose the new arrivals from Woking also helped to restore confidence.
At any rate, as the dusk came on a slow, intermittent movement upon the
sand-pits began, a movement that seemed to gather force as the
stillness of the evening about the cylinder remained unbroken. Vertical
black figures in twos and threes would advance, stop, watch, and
advance again, spreading out as they did so in a thin irregular
crescent that promised to enclose the pit in its attenuated horns. I,
too, on my side began to move towards the pit.', 114, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a7a87ad5038ef70eb95f693feb9bae9d3655e0c84b7de74b4b3dece62f6c4914', 'Then I saw some cabmen and others had walked boldly into the sand-pits,
and heard the clatter of hoofs and the gride of wheels. I saw a lad
trundling off the barrow of apples. And then, within thirty yards of
the pit, advancing from the direction of Horsell, I noted a little
black knot of men, the foremost of whom was waving a white flag.', 115, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8cacdcb1e032b1a6b6907a9b73ca9404b3c3521a2cc048332e79651211c39374', 'This was the Deputation. There had been a hasty consultation, and since
the Martians were evidently, in spite of their repulsive forms,
intelligent creatures, it had been resolved to show them, by
approaching them with signals, that we too were intelligent.', 116, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('76cf56b289072324e685a93a09aba002d334df2bc9e8754537debe5ee9761932', 'Flutter, flutter, went the flag, first to the right, then to the left.
It was too far for me to recognise anyone there, but afterwards I
learned that Ogilvy, Stent, and Henderson were with others in this
attempt at communication. This little group had in its advance dragged
inward, so to speak, the circumference of the now almost complete
circle of people, and a number of dim black figures followed it at
discreet distances.', 117, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('423cc026295c9f649092dd2926ed23e65fcd22731f9b00aa4a77d5a42c046cef', 'Suddenly there was a flash of light, and a quantity of luminous
greenish smoke came out of the pit in three distinct puffs, which drove
up, one after the other, straight into the still air.', 118, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('abecc4d55e3dbb90b79a45faefc8aeba32cf7fb4e296d8bd4c25ff9d0a1c1cf0', 'This smoke (or flame, perhaps, would be the better word for it) was so
bright that the deep blue sky overhead and the hazy stretches of brown
common towards Chertsey, set with black pine trees, seemed to darken
abruptly as these puffs arose, and to remain the darker after their
dispersal. At the same time a faint hissing sound became audible.', 119, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0b776a1413b18a1e5d78727dd0cc4525d9389399ef50607be159b9e00fde1a85', 'Beyond the pit stood the little wedge of people with the white flag at
its apex, arrested by these phenomena, a little knot of small vertical
black shapes upon the black ground. As the green smoke arose, their
faces flashed out pallid green, and faded again as it vanished. Then
slowly the hissing passed into a humming, into a long, loud, droning
noise. Slowly a humped shape rose out of the pit, and the ghost of a
beam of light seemed to flicker out from it.', 120, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e3e77dc8a4f90d475dc2e4d389578910661baa3e253cf60e85e0aa157061218', 'Forthwith flashes of actual flame, a bright glare leaping from one to
another, sprang from the scattered group of men. It was as if some
invisible jet impinged upon them and flashed into white flame. It was
as if each man were suddenly and momentarily turned to fire.', 121, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('032d94f4028fdad4207ca1b240dacf0e54d8f3cc4c02d2354c6d17d8e275152d', 'Then, by the light of their own destruction, I saw them staggering and
falling, and their supporters turning to run.', 122, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a0cb874cf4b615b8bad0516d2fae84cf059f45b669776c35c6a450a30c9f3f69', 'I stood staring, not as yet realising that this was death leaping from
man to man in that little distant crowd. All I felt was that it was
something very strange. An almost noiseless and blinding flash of
light, and a man fell headlong and lay still; and as the unseen shaft
of heat passed over them, pine trees burst into fire, and every dry
furze bush became with one dull thud a mass of flames. And far away
towards Knaphill I saw the flashes of trees and hedges and wooden
buildings suddenly set alight.', 123, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c7c4db305bb304dddd13e912701b50ed63c560ef65f02e8ac648bcb95344cf30', 'It was sweeping round swiftly and steadily, this flaming death, this
invisible, inevitable sword of heat. I perceived it coming towards me
by the flashing bushes it touched, and was too astounded and stupefied
to stir. I heard the crackle of fire in the sand-pits and the sudden
squeal of a horse that was as suddenly stilled. Then it was as if an
invisible yet intensely heated finger were drawn through the heather
between me and the Martians, and all along a curving line beyond the
sand-pits the dark ground smoked and crackled. Something fell with a
crash far away to the left where the road from Woking station opens out
on the common. Forth-with the hissing and humming ceased, and the
black, dome-like object sank slowly out of sight into the pit.', 124, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fdece04fbbe72981d5ddcc4b9231a33d9067cfb12e2d939a19eec92aff0b04ff', 'All this had happened with such swiftness that I had stood motionless,
dumbfounded and dazzled by the flashes of light. Had that death swept
through a full circle, it must inevitably have slain me in my surprise.
But it passed and spared me, and left the night about me suddenly dark
and unfamiliar.', 125, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('221f18d1968fa4529cc5c92ca8e6c71de0d62470cc7658a1f853cb366c011592', 'The undulating common seemed now dark almost to blackness, except where
its roadways lay grey and pale under the deep blue sky of the early
night. It was dark, and suddenly void of men. Overhead the stars were
mustering, and in the west the sky was still a pale, bright, almost
greenish blue. The tops of the pine trees and the roofs of Horsell came
out sharp and black against the western afterglow. The Martians and
their appliances were altogether invisible, save for that thin mast
upon which their restless mirror wobbled. Patches of bush and isolated
trees here and there smoked and glowed still, and the houses towards
Woking station were sending up spires of flame into the stillness of
the evening air.', 126, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a3fbe5e3075832ce6a879b88ef07aa115b194aa60156b6a70a0ef304b35dadf7', 'Nothing was changed save for that and a terrible astonishment. The
little group of black specks with the flag of white had been swept out
of existence, and the stillness of the evening, so it seemed to me, had
scarcely been broken.', 127, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f6d22e6b728b787c9c1705b788c6f04f7be32eb32f8016ebdd35811b3610a0bc', 'I thought, surveying him.', 803, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('267fa9339f9f7e077192bc065e592569c3fa9cac71ced358d9602a2e416c2213', 'It came to me that I was upon this dark common, helpless, unprotected,
and alone. Suddenly, like a thing falling upon me from without,
came—fear.', 128, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('463d84f1362cfb7bfd650549f409b19714039efff8238807a45c07b469affef7', 'With an effort I turned and began a stumbling run through the heather.', 129, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ace95732a914909581086ba798cd414db0ff036a94caa0a7fda623a874b373c8', 'The fear I felt was no rational fear, but a panic terror not only of
the Martians, but of the dusk and stillness all about me. Such an
extraordinary effect in unmanning me it had that I ran weeping silently
as a child might do. Once I had turned, I did not dare to look back.', 130, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c6cfba42d7237b95ca45e1c0f29b3762f8599725d98a4aea2bd8ff936dea7841', 'I remember I felt an extraordinary persuasion that I was being played
with, that presently, when I was upon the very verge of safety, this
mysterious death—as swift as the passage of light—would leap after me
from the pit about the cylinder, and strike me down.', 131, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('22ffb162be75610fbfe1528dcc405ffd1c2d9d5a915c4aa4816c281bc2abb028', '', 132, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('42b57c8e36403e86b0cc9c88bfa3f8c9fc3670391e94c9d997a8fae346e533bd', '
VI.
THE HEAT-RAY IN THE CHOBHAM ROAD.', 133, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e6b9a5dc084d669da420d813d3254cb68099d40a53e809ab0e2b617cbe31082c', '
It is still a matter of wonder how the Martians are able to slay men so
swiftly and so silently. Many think that in some way they are able to
generate an intense heat in a chamber of practically absolute
non-conductivity. This intense heat they project in a parallel beam
against any object they choose, by means of a polished parabolic mirror
of unknown composition, much as the parabolic mirror of a lighthouse
projects a beam of light. But no one has absolutely proved these
details. However it is done, it is certain that a beam of heat is the
essence of the matter. Heat, and invisible, instead of visible, light.
Whatever is combustible flashes into flame at its touch, lead runs like
water, it softens iron, cracks and melts glass, and when it falls upon
water, incontinently that explodes into steam.', 134, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('17d4240e0511c2724cbe973da75c78c3912ec7ec0e0b1fc5b30b24a973512189', 'That night nearly forty people lay under the starlight about the pit,
charred and distorted beyond recognition, and all night long the common
from Horsell to Maybury was deserted and brightly ablaze.', 135, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d44b2b14be127330084bffd3f536478d833c5ece2830a36732596712eb12b20e', 'The news of the massacre probably reached Chobham, Woking, and
Ottershaw about the same time. In Woking the shops had closed when the
tragedy happened, and a number of people, shop people and so forth,
attracted by the stories they had heard, were walking over the Horsell
Bridge and along the road between the hedges that runs out at last upon
the common. You may imagine the young people brushed up after the
labours of the day, and making this novelty, as they would make any
novelty, the excuse for walking together and enjoying a trivial
flirtation. You may figure to yourself the hum of voices along the road
in the gloaming. . . .', 136, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d0fbddb8ab4a645d991f38c6cb764c9ddbd5e9deeb61d6beb7fefb41cf7c2f5', 'As yet, of course, few people in Woking even knew that the cylinder had
opened, though poor Henderson had sent a messenger on a bicycle to the
post office with a special wire to an evening paper.', 137, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f3fcc10ce1f3c51b07ac8dbe4fc0806ba2cec89eae2a2d538e9c5ce9f577448e', 'As these folks came out by twos and threes upon the open, they found
little knots of people talking excitedly and peering at the spinning
mirror over the sand-pits, and the newcomers were, no doubt, soon
infected by the excitement of the occasion.', 138, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4b858cca77ce3a8a8d529ca3f884930be8ef702e39467ff3376695b2f3d3273', 'By half past eight, when the Deputation was destroyed, there may have
been a crowd of three hundred people or more at this place, besides
those who had left the road to approach the Martians nearer. There were
three policemen too, one of whom was mounted, doing their best, under
instructions from Stent, to keep the people back and deter them from
approaching the cylinder. There was some booing from those more
thoughtless and excitable souls to whom a crowd is always an occasion
for noise and horse-play.', 139, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8942c206a634db45d9bb0e4107429bd9112b318365d149f699800ed65e65b1b0', 'Stent and Ogilvy, anticipating some possibilities of a collision, had
telegraphed from Horsell to the barracks as soon as the Martians
emerged, for the help of a company of soldiers to protect these strange
creatures from violence. After that they returned to lead that
ill-fated advance. The description of their death, as it was seen by
the crowd, tallies very closely with my own impressions: the three
puffs of green smoke, the deep humming note, and the flashes of flame.', 140, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('05d9cd809aa27e7554c813f9b87ef10bb525c2048c4d351f05b38c50b86fa30d', 'But that crowd of people had a far narrower escape than mine. Only the
fact that a hummock of heathery sand intercepted the lower part of the
Heat-Ray saved them. Had the elevation of the parabolic mirror been a
few yards higher, none could have lived to tell the tale. They saw the
flashes and the men falling and an invisible hand, as it were, lit the
bushes as it hurried towards them through the twilight. Then, with a
whistling note that rose above the droning of the pit, the beam swung
close over their heads, lighting the tops of the beech trees that line
the road, and splitting the bricks, smashing the windows, firing the
window frames, and bringing down in crumbling ruin a portion of the
gable of the house nearest the corner.', 141, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('115be7895fbad14c929df7d13e70b7fba6454c311b476c8670c7ed3a7a665b9a', 'In the sudden thud, hiss, and glare of the igniting trees, the
panic-stricken crowd seems to have swayed hesitatingly for some
moments. Sparks and burning twigs began to fall into the road, and
single leaves like puffs of flame. Hats and dresses caught fire. Then
came a crying from the common. There were shrieks and shouts, and
suddenly a mounted policeman came galloping through the confusion with
his hands clasped over his head, screaming.', 142, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('57dd44c22e8a8976de386aa32550e1d147101c72f83ec30b6a4510444d2eef55', 'I startled my wife at the doorway, so haggard was I. I went into the
dining room, sat down, drank some wine, and so soon as I could collect
myself sufficiently I told her the things I had seen. The dinner, which
was a cold one, had already been served, and remained neglected on the
table while I told my story.', 164, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('df2883471c5d4938a8668e8b3736150eaa6a6fcc91daa5b307ab7b0d6531066c', '“They’re coming!” a woman shrieked, and incontinently everyone was
turning and pushing at those behind, in order to clear their way to
Woking again. They must have bolted as blindly as a flock of sheep.
Where the road grows narrow and black between the high banks the crowd
jammed, and a desperate struggle occurred. All that crowd did not
escape; three persons at least, two women and a little boy, were
crushed and trampled there, and left to die amid the terror and the
darkness.', 143, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6b1775de2c8a28c156cc76d1c0d0a0c353b25b298d1f41fa2f1537e82a684cce', '', 144, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4386a2593c01ea573231ba833bb001baa3a5266f07159f4d4e5bbecc5a9f534', '
VII.
HOW I REACHED HOME.', 145, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f76060e81f0c63cb37f09d90bdf878cbe853170115ca800113238aab7f502621', '
For my own part, I remember nothing of my flight except the stress of
blundering against trees and stumbling through the heather. All about
me gathered the invisible terrors of the Martians; that pitiless sword
of heat seemed whirling to and fro, flourishing overhead before it
descended and smote me out of life. I came into the road between the
crossroads and Horsell, and ran along this to the crossroads.', 146, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('61852c1a4c162a3577d5803ff9b6f23aae0c7f66b0042f3717db2c153922439a', 'At last I could go no further; I was exhausted with the violence of my
emotion and of my flight, and I staggered and fell by the wayside. That
was near the bridge that crosses the canal by the gasworks. I fell and
lay still.', 147, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('373cc7c3a3e1d51e151aee228fbf8b36bc94020d57f0ac76f302e970f718aa0b', 'I must have remained there some time.', 148, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2b72acd3477ba2c380e778e217ea5291ef6321d1be0d074fee1d4c2709fc895b', 'I sat up, strangely perplexed. For a moment, perhaps, I could not
clearly understand how I came there. My terror had fallen from me like
a garment. My hat had gone, and my collar had burst away from its
fastener. A few minutes before, there had only been three real things
before me—the immensity of the night and space and nature, my own
feebleness and anguish, and the near approach of death. Now it was as
if something turned over, and the point of view altered abruptly. There
was no sensible transition from one state of mind to the other. I was
immediately the self of every day again—a decent, ordinary citizen. The
silent common, the impulse of my flight, the starting flames, were as
if they had been in a dream. I asked myself had these latter things
indeed happened? I could not credit it.', 149, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c1a90c36ee2c26ba9493f74566219ee6cafbc6dfcd84c188f231e0c239a50ac1', 'I rose and walked unsteadily up the steep incline of the bridge. My
mind was blank wonder. My muscles and nerves seemed drained of their
strength. I dare say I staggered drunkenly. A head rose over the arch,
and the figure of a workman carrying a basket appeared. Beside him ran
a little boy. He passed me, wishing me good night. I was minded to
speak to him, but did not. I answered his greeting with a meaningless
mumble and went on over the bridge.', 150, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7ea1b39083c2ded93f2b37e41f6888052817f65306e7e7b43952a4296c308fef', 'Over the Maybury arch a train, a billowing tumult of white, firelit
smoke, and a long caterpillar of lighted windows, went flying
south—clatter, clatter, clap, rap, and it had gone. A dim group of
people talked in the gate of one of the houses in the pretty little row
of gables that was called Oriental Terrace. It was all so real and so
familiar. And that behind me! It was frantic, fantastic! Such things, I
told myself, could not be.', 151, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('57722913865ec05a180802b7fac4f4d382f3c1dace5d1a617ed742c9149fa9a1', 'Perhaps I am a man of exceptional moods. I do not know how far my
experience is common. At times I suffer from the strangest sense of
detachment from myself and the world about me; I seem to watch it all
from the outside, from somewhere inconceivably remote, out of time, out
of space, out of the stress and tragedy of it all. This feeling was
very strong upon me that night. Here was another side to my dream.', 152, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ed2863babab939d04b1ee4036f8a3c84d01b30bcb097b3b8a750c64b6d9bde19', 'But the trouble was the blank incongruity of this serenity and the
swift death flying yonder, not two miles away. There was a noise of
business from the gasworks, and the electric lamps were all alight. I
stopped at the group of people.', 153, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0ffcff105d088daa91263da1f1c3b06dc61cb68b99abe986a1d1b2e4d974621f', '“What news from the common?” said I.', 154, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4ee44a5a2eca96d437a02a12229509b62e9cfc46312b83b1e678d16c31e79a4d', 'There were two men and a woman at the gate.', 155, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('86d6c087f2d5ab36be7197a4ee53314c0ab6eeaa8429b98d353497a6b53905f7', '“Eh?” said one of the men, turning.', 156, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e9b27dbcccb826f27d4f4040375006cdc76e74ab15363536deb87bb024c1e140', '“What news from the common?” I said.', 157, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('313f8981a0f8e2a297e7f70af51edc2b09c81a5466a5c16b964db99d6e34abf9', '“Ain’t yer just _been_ there?” asked the men.', 158, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c6d460a47094a520e455a669f123702c07e0f548e8f8a95132598da0c5590edf', '“People seem fair silly about the common,” said the woman over the
gate. “What’s it all abart?”', 159, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('89714625821889ed7da2dec58c7e48c8f3fbdb428aab101e721e60a5f80b9f1a', '“Haven’t you heard of the men from Mars?” said I; “the creatures from
Mars?”', 160, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('314238bcaa8d32859eecafb1954bbdb1a37d9ba07265caf07863c060460e7d7c', '“Quite enough,” said the woman over the gate. “Thenks”; and all three
of them laughed.', 161, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3a48a673d114e7b6c17822b5629a242ea21dab9bb3670932445cb5b3d122a9f9', 'I felt foolish and angry. I tried and found I could not tell them what
I had seen. They laughed again at my broken sentences.', 162, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('217927864f78910c2572d55469e241be83f870be5188885839b5aab04a7ccb72', '“You’ll hear more yet,” I said, and went on to my home.', 163, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5c5f6af05e8ba7867836a3c1cef9c4d08e4ac49911806a6a4efce4100e0b1192', '“It’s a pity they make themselves so unapproachable,” he said. “It
would be curious to know how they live on another planet; we might
learn a thing or two.”', 198, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9cc85e395148ec0eaf965c1e67a8cf6b759dfb2493330eb158ebaf92536464a1', '“There is one thing,” I said, to allay the fears I had aroused; “they
are the most sluggish things I ever saw crawl. They may keep the pit
and kill people who come near them, but they cannot get out of it. . .
. But the horror of them!”', 165, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('92d5f66eb50ac44e43d299a38b8b1d81ebfabb1b4e19100184e300d4f661e197', '“Don’t, dear!” said my wife, knitting her brows and putting her hand on
mine.', 166, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4a0d19daa75f9f4814bd1ec08f1e8f302ded27a1551821994e621e6b5a91871c', '“Poor Ogilvy!” I said. “To think he may be lying dead there!”', 167, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('76882321b3a5ab96ed901385cb8b71c54270de1963b4bbe41537618904cf5bdd', 'My wife at least did not find my experience incredible. When I saw how
deadly white her face was, I ceased abruptly.', 168, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a8f5d1043f34465ecb5eb6a55e3b303430256b23510c5c184370fa29c6dee72a', '“They may come here,” she said again and again.', 169, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fc21e2554b1d629c25ef822713b374a7606bd9bbe91e28a350c23ee133e8a466', 'I pressed her to take wine, and tried to reassure her.', 170, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('59a893d9366f283eafe3619838379ebc934fb93d4de5ca4b5365ae0cd459b0f1', '“They can scarcely move,” I said.', 171, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('301bade20b2789a565a434ee52e02c4de20edff295ffc1425034ed7a94fcc4c1', 'I began to comfort her and myself by repeating all that Ogilvy had told
me of the impossibility of the Martians establishing themselves on the
earth. In particular I laid stress on the gravitational difficulty. On
the surface of the earth the force of gravity is three times what it is
on the surface of Mars. A Martian, therefore, would weigh three times
more than on Mars, albeit his muscular strength would be the same. His
own body would be a cope of lead to him, therefore. That, indeed, was
the general opinion. Both _The Times_ and the _Daily Telegraph_, for
instance, insisted on it the next morning, and both overlooked, just as
I did, two obvious modifying influences.', 172, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0b7f785fc74876971f262d726f4d8601232f7485ca02d393bb62a0806c2ab314', 'The atmosphere of the earth, we now know, contains far more oxygen or
far less argon (whichever way one likes to put it) than does Mars’. The
invigorating influences of this excess of oxygen upon the Martians
indisputably did much to counterbalance the increased weight of their
bodies. And, in the second place, we all overlooked the fact that such
mechanical intelligence as the Martian possessed was quite able to
dispense with muscular exertion at a pinch.', 173, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b3ac7bda4edca1c99f65bacb2e5d7f4a21b7af7867f995f06819c3419133cca3', 'But I did not consider these points at the time, and so my reasoning
was dead against the chances of the invaders. With wine and food, the
confidence of my own table, and the necessity of reassuring my wife, I
grew by insensible degrees courageous and secure.', 174, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('54dfb4b822c2bcb01037e26556539ef474a9baf9c9483e13c110fa6a262b29ec', '“They have done a foolish thing,” said I, fingering my wineglass. “They
are dangerous because, no doubt, they are mad with terror. Perhaps they
expected to find no living things—certainly no intelligent living
things.”', 175, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2ffa10dbc21550197f03ff1fdb32bea7136111746bac6ac775c5ed7bf44c4983', '“A shell in the pit,” said I, “if the worst comes to the worst, will
kill them all.”', 176, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ae9abe476e072f49ed18aea6d0f044a4fa35dd274292433798735d98f7663464', 'The intense excitement of the events had no doubt left my perceptive
powers in a state of erethism. I remember that dinner table with
extraordinary vividness even now. My dear wife’s sweet anxious face
peering at me from under the pink lamp shade, the white cloth with its
silver and glass table furniture—for in those days even philosophical
writers had many little luxuries—the crimson-purple wine in my glass,
are photographically distinct. At the end of it I sat, tempering nuts
with a cigarette, regretting Ogilvy’s rashness, and denouncing the
short-sighted timidity of the Martians.', 177, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bf1479ef2f63caacdd24f035384f2b18707b96ac617a038959d239e6ced94bd1', 'So some respectable dodo in the Mauritius might have lorded it in his
nest, and discussed the arrival of that shipful of pitiless sailors in
want of animal food. “We will peck them to death tomorrow, my dear.”', 178, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c698448a0944517ac80036db96a6360ab0ea6e9ca019ad09ff60e445f70481fe', 'I did not know it, but that was the last civilised dinner I was to eat
for very many strange and terrible days.', 179, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b4a709ebd7777937938f48f3d83fea17f8ea781f5a1a0ec9dd9d309df8ca388c', '', 180, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('95d002db6f9219c15fed45ed3b911c4c29857c08908c03e42ea3fab3be531b35', '
VIII.
FRIDAY NIGHT.', 181, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2f481d2f6b5ae82f16ab4576d3ef5d51f0ddcfa82647ff693d6a3690643b3986', '
The most extraordinary thing to my mind, of all the strange and
wonderful things that happened upon that Friday, was the dovetailing of
the commonplace habits of our social order with the first beginnings of
the series of events that was to topple that social order headlong. If
on Friday night you had taken a pair of compasses and drawn a circle
with a radius of five miles round the Woking sand-pits, I doubt if you
would have had one human being outside it, unless it were some relation
of Stent or of the three or four cyclists or London people lying dead
on the common, whose emotions or habits were at all affected by the
new-comers. Many people had heard of the cylinder, of course, and
talked about it in their leisure, but it certainly did not make the
sensation that an ultimatum to Germany would have done.', 182, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0792362429755103151e0276a29a275d030c81f6914a95572a6660655f792c32', 'In London that night poor Henderson’s telegram describing the gradual
unscrewing of the shot was judged to be a canard, and his evening
paper, after wiring for authentication from him and receiving no
reply—the man was killed—decided not to print a special edition.', 183, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0d0dff7d30e0544d006ef77b895bf26c0b680ae217a2598780f14a3122cfac4f', 'He came up to the fence and extended a handful of strawberries, for his
gardening was as generous as it was enthusiastic. At the same time he
told me of the burning of the pine woods about the Byfleet Golf Links.', 199, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7ec424317dc8b8c88707919ffaa501ed72994c392bbc38478a36d58933ba2b49', 'Even within the five-mile circle the great majority of people were
inert. I have already described the behaviour of the men and women to
whom I spoke. All over the district people were dining and supping;
working men were gardening after the labours of the day, children were
being put to bed, young people were wandering through the lanes
love-making, students sat over their books.', 184, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('44c40d99f77c40ac395749ba592d87cd299db049be1748408e82c89bf56f4290', 'Maybe there was a murmur in the village streets, a novel and dominant
topic in the public-houses, and here and there a messenger, or even an
eye-witness of the later occurrences, caused a whirl of excitement, a
shouting, and a running to and fro; but for the most part the daily
routine of working, eating, drinking, sleeping, went on as it had done
for countless years—as though no planet Mars existed in the sky. Even
at Woking station and Horsell and Chobham that was the case.', 185, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b0c355b2551b379a6c126f3df1939e4c855c97cece3cd0b476555c2c876c5d03', 'In Woking junction, until a late hour, trains were stopping and going
on, others were shunting on the sidings, passengers were alighting and
waiting, and everything was proceeding in the most ordinary way. A boy
from the town, trenching on Smith’s monopoly, was selling papers with
the afternoon’s news. The ringing impact of trucks, the sharp whistle
of the engines from the junction, mingled with their shouts of “Men
from Mars!” Excited men came into the station about nine o’clock with
incredible tidings, and caused no more disturbance than drunkards might
have done. People rattling Londonwards peered into the darkness outside
the carriage windows, and saw only a rare, flickering, vanishing spark
dance up from the direction of Horsell, a red glow and a thin veil of
smoke driving across the stars, and thought that nothing more serious
than a heath fire was happening. It was only round the edge of the
common that any disturbance was perceptible. There were half a dozen
villas burning on the Woking border. There were lights in all the
houses on the common side of the three villages, and the people there
kept awake till dawn.', 186, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eeb64ad2be2a3f3c5bc8b5387a16fd4e24c8fbc5e49bcd1ab407f331d86fa060', 'A curious crowd lingered restlessly, people coming and going but the
crowd remaining, both on the Chobham and Horsell bridges. One or two
adventurous souls, it was afterwards found, went into the darkness and
crawled quite near the Martians; but they never returned, for now and
again a light-ray, like the beam of a warship’s searchlight swept the
common, and the Heat-Ray was ready to follow. Save for such, that big
area of common was silent and desolate, and the charred bodies lay
about on it all night under the stars, and all the next day. A noise of
hammering from the pit was heard by many people.', 187, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7de4955a3260eb07ca43dde8740070dc5fc8248cb8fd706117bee465b330a144', 'So you have the state of things on Friday night. In the centre,
sticking into the skin of our old planet Earth like a poisoned dart,
was this cylinder. But the poison was scarcely working yet. Around it
was a patch of silent common, smouldering in places, and with a few
dark, dimly seen objects lying in contorted attitudes here and there.
Here and there was a burning bush or tree. Beyond was a fringe of
excitement, and farther than that fringe the inflammation had not crept
as yet. In the rest of the world the stream of life still flowed as it
had flowed for immemorial years. The fever of war that would presently
clog vein and artery, deaden nerve and destroy brain, had still to
develop.', 188, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5ee8cd832d36180776d08c18f9a7aa258c356496aa1e002c0784f6d7ecc6142c', 'All night long the Martians were hammering and stirring, sleepless,
indefatigable, at work upon the machines they were making ready, and
ever and again a puff of greenish-white smoke whirled up to the starlit
sky.', 189, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d1967d3cde74b1622b0950754f407da330c4d3f6e7774e61dad883ff2d12afcc', 'About eleven a company of soldiers came through Horsell, and deployed
along the edge of the common to form a cordon. Later a second company
marched through Chobham to deploy on the north side of the common.
Several officers from the Inkerman barracks had been on the common
earlier in the day, and one, Major Eden, was reported to be missing.
The colonel of the regiment came to the Chobham bridge and was busy
questioning the crowd at midnight. The military authorities were
certainly alive to the seriousness of the business. About eleven, the
next morning’s papers were able to say, a squadron of hussars, two
Maxims, and about four hundred men of the Cardigan regiment started
from Aldershot.', 190, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6c880c8e165ef31229479358057c26385d76ed6a121772c8e773ac7b5cd26231', 'A few seconds after midnight the crowd in the Chertsey road, Woking,
saw a star fall from heaven into the pine woods to the northwest. It
had a greenish colour, and caused a silent brightness like summer
lightning. This was the second cylinder.', 191, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4601818f8a76f00e6719f15f2e871b681c526bad1fd1f106408dc5b6fb19557e', '', 192, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f684f65c7151a906ec8503e5dadbe6e4ccca43a61f570bcdf3733229a76710d8', '
IX.
THE FIGHTING BEGINS.', 193, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5c2ba6c522b0c958232d3bce6d64b7d1f1183146dd74947cba4c3f7d0b99c259', '
Saturday lives in my memory as a day of suspense. It was a day of
lassitude too, hot and close, with, I am told, a rapidly fluctuating
barometer. I had slept but little, though my wife had succeeded in
sleeping, and I rose early. I went into my garden before breakfast and
stood listening, but towards the common there was nothing stirring but
a lark.', 194, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6a4c90d7da04bb1151e1d402e2604ea8c9ece7877d5122cce9e709e4eebedfa7', 'The milkman came as usual. I heard the rattle of his chariot and I went
round to the side gate to ask the latest news. He told me that during
the night the Martians had been surrounded by troops, and that guns
were expected. Then—a familiar, reassuring note—I heard a train running
towards Woking.', 195, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('116e91957323f3ed49af2c2e76c54374fee313e5d4cc09587c776e9e20979616', '“They aren’t to be killed,” said the milkman, “if that can possibly be
avoided.”', 196, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8496be78553bec01dd927c9cdac73dbb70a6f8f1720e35de9a7c8b87655918b4', 'I saw my neighbour gardening, chatted with him for a time, and then
strolled in to breakfast. It was a most unexceptional morning. My
neighbour was of opinion that the troops would be able to capture or to
destroy the Martians during the day.', 197, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6829a715f5e2dc0c7669729a4a90c02dad50bffbc0323bd93902fa1d4c50dfcf', '“You are the artilleryman who came into my garden.”', 813, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e49397fd5eb072999419de4daac0bacfbcc46c9f16890b7201c1fc2d7306cd53', '“They say,” said he, “that there’s another of those blessed things
fallen there—number two. But one’s enough, surely. This lot’ll cost the
insurance people a pretty penny before everything’s settled.” He
laughed with an air of the greatest good humour as he said this. The
woods, he said, were still burning, and pointed out a haze of smoke to
me. “They will be hot under foot for days, on account of the thick soil
of pine needles and turf,” he said, and then grew serious over “poor
Ogilvy.”', 200, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('717f21629cfd90f903d415e25b883c80c98eee22f325ff9b9568da000ade56ce', 'After breakfast, instead of working, I decided to walk down towards the
common. Under the railway bridge I found a group of soldiers—sappers, I
think, men in small round caps, dirty red jackets unbuttoned, and
showing their blue shirts, dark trousers, and boots coming to the calf.
They told me no one was allowed over the canal, and, looking along the
road towards the bridge, I saw one of the Cardigan men standing
sentinel there. I talked with these soldiers for a time; I told them of
my sight of the Martians on the previous evening. None of them had seen
the Martians, and they had but the vaguest ideas of them, so that they
plied me with questions. They said that they did not know who had
authorised the movements of the troops; their idea was that a dispute
had arisen at the Horse Guards. The ordinary sapper is a great deal
better educated than the common soldier, and they discussed the
peculiar conditions of the possible fight with some acuteness. I
described the Heat-Ray to them, and they began to argue among
themselves.', 201, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('29fa61bff64f339953e4e2cf469934b48da852b199059f404abd123d6dac2f45', '“Crawl up under cover and rush ’em, say I,” said one.', 202, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4eec10ef99a5d8d32a3d397a2a5e1bed68d29ac2da14e74dfacc0d3a21370dd4', '“Get aht!” said another. “What’s cover against this ’ere ’eat? Sticks
to cook yer! What we got to do is to go as near as the ground’ll let
us, and then drive a trench.”', 203, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e7806361e8009794066536b530f3cf438b62c2f9f65fff64d6b26460d3dd3397', '“Blow yer trenches! You always want trenches; you ought to ha’ been
born a rabbit Snippy.”', 204, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('03d6cb430edaf6f3464add4eab0b5cb96a87bd1486d5e59f25a7535e91e1f180', '“Ain’t they got any necks, then?” said a third, abruptly—a little,
contemplative, dark man, smoking a pipe.', 205, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4257b1dcc41114c0faaa2fb2d83e9ed6db4342370c71213478172d307c3241cb', 'I repeated my description.', 206, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('60b5df5cded515698d11bf590470e55d116913ed2d9f59fd4361c4acaa8cc5ca', '“Octopuses,” said he, “that’s what I calls ’em. Talk about fishers of
men—fighters of fish it is this time!”', 207, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fee7375e2da8a800f6275cb2bfa6e080a6e8e111fc83a907c106e7c730393511', '“It ain’t no murder killing beasts like that,” said the first speaker.', 208, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8997ea132643a37f4178a501ce46c2f5b2429a717d58657b8dd0c5a694b1ebe5', '“Why not shell the darned things strite off and finish ’em?” said the
little dark man. “You carn tell what they might do.”', 209, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8ed23cec873c026b1373ff8859f4ac1978ce4d975985cb0b7c5d315ef88578b0', '“Where’s your shells?” said the first speaker. “There ain’t no time. Do
it in a rush, that’s my tip, and do it at once.”', 210, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f1680cc29e43f6b4d0feccd0a89f0439e56c0ccb8c0e7d2b8891d7dc99acc7f3', 'So they discussed it. After a while I left them, and went on to the
railway station to get as many morning papers as I could.', 211, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6c8f7eeeef697dc91e795120481f4e7d0bbece62a56bb05ab9fe90c3b83563cb', 'But I will not weary the reader with a description of that long morning
and of the longer afternoon. I did not succeed in getting a glimpse of
the common, for even Horsell and Chobham church towers were in the
hands of the military authorities. The soldiers I addressed didn’t know
anything; the officers were mysterious as well as busy. I found people
in the town quite secure again in the presence of the military, and I
heard for the first time from Marshall, the tobacconist, that his son
was among the dead on the common. The soldiers had made the people on
the outskirts of Horsell lock up and leave their houses.', 212, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3cf9abf638938116a819ce6029ad0f94ec7f0eaabb723ae0162dce23ac236314', 'I got back to lunch about two, very tired for, as I have said, the day
was extremely hot and dull; and in order to refresh myself I took a
cold bath in the afternoon. About half past four I went up to the
railway station to get an evening paper, for the morning papers had
contained only a very inaccurate description of the killing of Stent,
Henderson, Ogilvy, and the others. But there was little I didn’t know.
The Martians did not show an inch of themselves. They seemed busy in
their pit, and there was a sound of hammering and an almost continuous
streamer of smoke. Apparently they were busy getting ready for a
struggle. “Fresh attempts have been made to signal, but without
success,” was the stereotyped formula of the papers. A sapper told me
it was done by a man in a ditch with a flag on a long pole. The
Martians took as much notice of such advances as we should of the
lowing of a cow.', 213, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e7594c2bcc99b72a7903bfb9adc27d823d96e05a57b5daafc4eadaf2ad55e693', 'I must confess the sight of all this armament, all this preparation,
greatly excited me. My imagination became belligerent, and defeated the
invaders in a dozen striking ways; something of my schoolboy dreams of
battle and heroism came back. It hardly seemed a fair fight to me at
that time. They seemed very helpless in that pit of theirs.', 214, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a1e81b110e4487cc0c6c79b055f4155a78a97df96adf32b47a5e51e62aa30d89', 'About three o’clock there began the thud of a gun at measured intervals
from Chertsey or Addlestone. I learned that the smouldering pine wood
into which the second cylinder had fallen was being shelled, in the
hope of destroying that object before it opened. It was only about
five, however, that a field gun reached Chobham for use against the
first body of Martians.', 215, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('61095de21007b055f16f981a9452fab2224038722670aa6db5d86ea74920b3c0', '“It’s bows and arrows against the lightning, anyhow,” said the
artilleryman. “They ’aven’t seen that fire-beam yet.”', 337, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('74acc0b2fe53e2bfe9d75961c1e986c83443d5de69f9c9a8b4125b836e43b5dd', '', 925, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e80b1e4d4fe7ce372ec2cfc1154c32b31d141fd192575209a527f02b66c4c88e', 'About six in the evening, as I sat at tea with my wife in the
summerhouse talking vigorously about the battle that was lowering upon
us, I heard a muffled detonation from the common, and immediately after
a gust of firing. Close on the heels of that came a violent rattling
crash, quite close to us, that shook the ground; and, starting out upon
the lawn, I saw the tops of the trees about the Oriental College burst
into smoky red flame, and the tower of the little church beside it
slide down into ruin. The pinnacle of the mosque had vanished, and the
roof line of the college itself looked as if a hundred-ton gun had been
at work upon it. One of our chimneys cracked as if a shot had hit it,
flew, and a piece of it came clattering down the tiles and made a heap
of broken red fragments upon the flower bed by my study window.', 216, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b92e02548f9d3ccb4694f01208c867762693ba7e0e3177e9dff75e3c5542d41c', 'I and my wife stood amazed. Then I realised that the crest of Maybury
Hill must be within range of the Martians’ Heat-Ray now that the
college was cleared out of the way.', 217, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('40b399edc9b57dda26e6c044a3986f46e9c1b72c67dc67f68d42cb6a5f5d3767', 'At that I gripped my wife’s arm, and without ceremony ran her out into
the road. Then I fetched out the servant, telling her I would go
upstairs myself for the box she was clamouring for.', 218, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('59e97aa315e6ca3f5307af3b0d2615ccb73c6c3e3ded7e5b889c56a78cdbf329', '“We can’t possibly stay here,” I said; and as I spoke the firing
reopened for a moment upon the common.', 219, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('086fac3038a31dfc6d22a59e2a04c1022abd1b464c75693dc7893dcb7c11e3e5', '“But where are we to go?” said my wife in terror.', 220, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ff366d160935b59a5bf55630401fd4ea8d6edffd4939e3177043b136b511be6c', 'I thought perplexed. Then I remembered her cousins at Leatherhead.', 221, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ada18dc80fa37f7bd72e6bfad73e1fb3ccc7595985decce26fc51de5969615ef', '“Leatherhead!” I shouted above the sudden noise.', 222, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('daa36bd4d214b3193e037abfaa40cedfc55460f4167f197935ce89e6534ca33f', 'She looked away from me downhill. The people were coming out of their
houses, astonished.', 223, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d69b0f25f9f48b337f0c73b83c6016dff79d4a32483bbdb6b0a3b173d86e55b6', '“How are we to get to Leatherhead?” she said.', 224, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0caf54eadc24a53d9592ddd611748198ae3662c7863c99aaba13bb8557773cca', 'Down the hill I saw a bevy of hussars ride under the railway bridge;
three galloped through the open gates of the Oriental College; two
others dismounted, and began running from house to house. The sun,
shining through the smoke that drove up from the tops of the trees,
seemed blood red, and threw an unfamiliar lurid light upon everything.', 225, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f08069ac9d3518993349ad682bd470e94ebbeb551de8960372735f4388640079', '“Stop here,” said I; “you are safe here”; and I started off at once for
the Spotted Dog, for I knew the landlord had a horse and dog cart. I
ran, for I perceived that in a moment everyone upon this side of the
hill would be moving. I found him in his bar, quite unaware of what was
going on behind his house. A man stood with his back to me, talking to
him.', 226, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ce5d004188a17abd543ae1b57a756df3e0b8a44ca8e8f9d2fcf1b17bfcde4e9d', '“I must have a pound,” said the landlord, “and I’ve no one to drive
it.”', 227, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c7303cb303615969dba4cd512e7176cb3d35f080aa24cf87b942008f6b435cd3', '“I’ll give you two,” said I, over the stranger’s shoulder.', 228, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f92261359f301f5d5bb32304e669015d373bc642f391a7f0b95fe0538c018b88', '“What for?”', 229, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9f9dfd478a7c6c977c232c8ced9f120f1319dd839a7c427c03bb2b07a535b143', '“And I’ll bring it back by midnight,” I said.', 230, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2a0cc2f188f23a02249abc86c5974f9edd43e1c9eb2e3dec0408e4bb79b2fe4e', '“Lord!” said the landlord; “what’s the hurry? I’m selling my bit of a
pig. Two pounds, and you bring it back? What’s going on now?”', 231, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('61c57b81e2173ea56291b3d07244f12c24a7f386bc6601f7173005f9db3d3e26', 'I explained hastily that I had to leave my home, and so secured the dog
cart. At the time it did not seem to me nearly so urgent that the
landlord should leave his. I took care to have the cart there and then,
drove it off down the road, and, leaving it in charge of my wife and
servant, rushed into my house and packed a few valuables, such plate as
we had, and so forth. The beech trees below the house were burning
while I did this, and the palings up the road glowed red. While I was
occupied in this way, one of the dismounted hussars came running up. He
was going from house to house, warning people to leave. He was going on
as I came out of my front door, lugging my treasures, done up in a
tablecloth. I shouted after him:', 232, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0c7a10f9fd1ac9be58f076216d211d767e537d70ecc91f3b0b6706b94f544939', '“What news?”', 233, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f932aeb8ed3416ff93f6706544a0398c8a4b2375872031cd405920401d25d001', 'He turned, stared, bawled something about “crawling out in a thing like
a dish cover,” and ran on to the gate of the house at the crest. A
sudden whirl of black smoke driving across the road hid him for a
moment. I ran to my neighbour’s door and rapped to satisfy myself of
what I already knew, that his wife had gone to London with him and had
locked up their house. I went in again, according to my promise, to get
my servant’s box, lugged it out, clapped it beside her on the tail of
the dog cart, and then caught the reins and jumped up into the driver’s
seat beside my wife. In another moment we were clear of the smoke and
noise, and spanking down the opposite slope of Maybury Hill towards Old
Woking.', 234, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0002ed4fa75855a7ae98c97cd3c4c1e7ff44270c0c62e3e16f3befd1f0a54d9f', 'A moderate incline runs towards the foot of Maybury Hill, and down this
we clattered. Once the lightning had begun, it went on in as rapid a
succession of flashes as I have ever seen. The thunderclaps, treading
one on the heels of another and with a strange crackling accompaniment,
sounded more like the working of a gigantic electric machine than the
usual detonating reverberations. The flickering light was blinding and
confusing, and a thin hail smote gustily at my face as I drove down the
slope.', 248, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('33aa4d3087c472330f9ead3766ef0e1369062f2068c6cc2eab9654bfcd1c48ad', 'In front was a quiet sunny landscape, a wheat field ahead on either
side of the road, and the Maybury Inn with its swinging sign. I saw the
doctor’s cart ahead of me. At the bottom of the hill I turned my head
to look at the hillside I was leaving. Thick streamers of black smoke
shot with threads of red fire were driving up into the still air, and
throwing dark shadows upon the green treetops eastward. The smoke
already extended far away to the east and west—to the Byfleet pine
woods eastward, and to Woking on the west. The road was dotted with
people running towards us. And very faint now, but very distinct
through the hot, quiet air, one heard the whirr of a machine-gun that
was presently stilled, and an intermittent cracking of rifles.
Apparently the Martians were setting fire to everything within range of
their Heat-Ray.', 235, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('da0410874cfe69a2f2516d798e22defc197a9296ed8072e070c5b87fe346fc0e', 'I am not an expert driver, and I had immediately to turn my attention
to the horse. When I looked back again the second hill had hidden the
black smoke. I slashed the horse with the whip, and gave him a loose
rein until Woking and Send lay between us and that quivering tumult. I
overtook and passed the doctor between Woking and Send.', 236, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ab89a82629388f7e3196332b79a58e93aefba759f753f97857afd49b6b060d44', '', 237, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8ec5f94341c2785c1000ed7b6dbd2bea6c841dce97fddb022708313e50f50396', '
X.
IN THE STORM.', 238, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('95a66a95032054370af129e68413f6e61ef6fb3e8981878e398608d72207f2c1', '
Leatherhead is about twelve miles from Maybury Hill. The scent of hay
was in the air through the lush meadows beyond Pyrford, and the hedges
on either side were sweet and gay with multitudes of dog-roses. The
heavy firing that had broken out while we were driving down Maybury
Hill ceased as abruptly as it began, leaving the evening very peaceful
and still. We got to Leatherhead without misadventure about nine
o’clock, and the horse had an hour’s rest while I took supper with my
cousins and commended my wife to their care.', 239, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0bcd4e389c6f0b10e9eca8691fb6f8c71acf1d77fbcb7f21e0b7d16cbedb3fb7', 'My wife was curiously silent throughout the drive, and seemed oppressed
with forebodings of evil. I talked to her reassuringly, pointing out
that the Martians were tied to the pit by sheer heaviness, and at the
utmost could but crawl a little out of it; but she answered only in
monosyllables. Had it not been for my promise to the innkeeper, she
would, I think, have urged me to stay in Leatherhead that night. Would
that I had! Her face, I remember, was very white as we parted.', 240, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c0361d1741c58ef8855c3e0de61c0ed8ffba62fd678855ac91a304814242849c', 'For my own part, I had been feverishly excited all day. Something very
like the war fever that occasionally runs through a civilised community
had got into my blood, and in my heart I was not so very sorry that I
had to return to Maybury that night. I was even afraid that that last
fusillade I had heard might mean the extermination of our invaders from
Mars. I can best express my state of mind by saying that I wanted to be
in at the death.', 241, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bf6f2a621b948590d7fbcc7408d083be2be9d236a47f9ca4ec72690a484f200b', 'It was nearly eleven when I started to return. The night was
unexpectedly dark; to me, walking out of the lighted passage of my
cousins’ house, it seemed indeed black, and it was as hot and close as
the day. Overhead the clouds were driving fast, albeit not a breath
stirred the shrubs about us. My cousins’ man lit both lamps. Happily, I
knew the road intimately. My wife stood in the light of the doorway,
and watched me until I jumped up into the dog cart. Then abruptly she
turned and went in, leaving my cousins side by side wishing me good
hap.', 242, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('535f1099de3f0a5d22d04932b0a806ce755ca0e512a90e25e72908306d2bea24', 'I was a little depressed at first with the contagion of my wife’s
fears, but very soon my thoughts reverted to the Martians. At that time
I was absolutely in the dark as to the course of the evening’s
fighting. I did not know even the circumstances that had precipitated
the conflict. As I came through Ockham (for that was the way I
returned, and not through Send and Old Woking) I saw along the western
horizon a blood-red glow, which as I drew nearer, crept slowly up the
sky. The driving clouds of the gathering thunderstorm mingled there
with masses of black and red smoke.', 243, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ca0b28fd67eb332bb86714f0643bb3a0f70db48e5faa9391e26a7ad0022d375c', 'Ripley Street was deserted, and except for a lighted window or so the
village showed not a sign of life; but I narrowly escaped an accident
at the corner of the road to Pyrford, where a knot of people stood with
their backs to me. They said nothing to me as I passed. I do not know
what they knew of the things happening beyond the hill, nor do I know
if the silent houses I passed on my way were sleeping securely, or
deserted and empty, or harassed and watching against the terror of the
night.', 244, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ec9c25d766d7d0da311bdcc49b90e0573335461c7840d20e797031ced80fe032', 'From Ripley until I came through Pyrford I was in the valley of the
Wey, and the red glare was hidden from me. As I ascended the little
hill beyond Pyrford Church the glare came into view again, and the
trees about me shivered with the first intimation of the storm that was
upon me. Then I heard midnight pealing out from Pyrford Church behind
me, and then came the silhouette of Maybury Hill, with its tree-tops
and roofs black and sharp against the red.', 245, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('42126bc82ef8eaa39997f2667704f63897f6ae6ec2bcf7f8dc4eee72f98f0da3', 'Even as I beheld this a lurid green glare lit the road about me and
showed the distant woods towards Addlestone. I felt a tug at the reins.
I saw that the driving clouds had been pierced as it were by a thread
of green fire, suddenly lighting their confusion and falling into the
field to my left. It was the third falling star!', 246, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2b608446784dfb9cc3e3c29b773cb64fe347854c4e3d526cc6b1f238885db7a2', 'Close on its apparition, and blindingly violet by contrast, danced out
the first lightning of the gathering storm, and the thunder burst like
a rocket overhead. The horse took the bit between his teeth and bolted.', 247, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4090263cd73e7969b3bae7a2ea6cfc7e7e3431bce576ac5dae3136b6f1a518f4', 'He gave a cry of terror, sprang sideways, and rushed on before I could
gather my wits sufficiently to speak to him. So heavy was the stress of
the storm just at this place that I had the hardest task to win my way
up the hill. I went close up to the fence on the left and worked my way
along its palings.', 262, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b7cb0dad2c26d4dde23998562442f7c059fb784d3a24d724ad3422e8bcddd87a', 'At first I regarded little but the road before me, and then abruptly my
attention was arrested by something that was moving rapidly down the
opposite slope of Maybury Hill. At first I took it for the wet roof of
a house, but one flash following another showed it to be in swift
rolling movement. It was an elusive vision—a moment of bewildering
darkness, and then, in a flash like daylight, the red masses of the
Orphanage near the crest of the hill, the green tops of the pine trees,
and this problematical object came out clear and sharp and bright.', 249, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('62329a00c5a4262c5976e0c85e426d89134bd929688ff8620439225497667259', 'And this Thing I saw! How can I describe it? A monstrous tripod, higher
than many houses, striding over the young pine trees, and smashing them
aside in its career; a walking engine of glittering metal, striding now
across the heather; articulate ropes of steel dangling from it, and the
clattering tumult of its passage mingling with the riot of the thunder.
A flash, and it came out vividly, heeling over one way with two feet in
the air, to vanish and reappear almost instantly as it seemed, with the
next flash, a hundred yards nearer. Can you imagine a milking stool
tilted and bowled violently along the ground? That was the impression
those instant flashes gave. But instead of a milking stool imagine it a
great body of machinery on a tripod stand.', 250, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4dce8f5f3781846a342ec5d29cb0a1c4fa34d5fd701515eaa963270291ad3e99', 'Then suddenly the trees in the pine wood ahead of me were parted, as
brittle reeds are parted by a man thrusting through them; they were
snapped off and driven headlong, and a second huge tripod appeared,
rushing, as it seemed, headlong towards me. And I was galloping hard to
meet it! At the sight of the second monster my nerve went altogether.
Not stopping to look again, I wrenched the horse’s head hard round to
the right and in another moment the dog cart had heeled over upon the
horse; the shafts smashed noisily, and I was flung sideways and fell
heavily into a shallow pool of water.', 251, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4149f13b23fde47b724916545a462ee2696f370fa16dec255cab61a67d0edcff', 'I crawled out almost immediately, and crouched, my feet still in the
water, under a clump of furze. The horse lay motionless (his neck was
broken, poor brute!) and by the lightning flashes I saw the black bulk
of the overturned dog cart and the silhouette of the wheel still
spinning slowly. In another moment the colossal mechanism went striding
by me, and passed uphill towards Pyrford.', 252, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0450ebba3ad991fa50b39b95b65b926150e58e8182990e88ddbadb797b25b50c', 'Seen nearer, the Thing was incredibly strange, for it was no mere
insensate machine driving on its way. Machine it was, with a ringing
metallic pace, and long, flexible, glittering tentacles (one of which
gripped a young pine tree) swinging and rattling about its strange
body. It picked its road as it went striding along, and the brazen hood
that surmounted it moved to and fro with the inevitable suggestion of a
head looking about. Behind the main body was a huge mass of white metal
like a gigantic fisherman’s basket, and puffs of green smoke squirted
out from the joints of the limbs as the monster swept by me. And in an
instant it was gone.', 253, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('aef54f9643e798dfc254c4ce2162140e3526c20e51c8ceee18e4d1b360afe677', 'So much I saw then, all vaguely for the flickering of the lightning, in
blinding highlights and dense black shadows.', 254, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5eb166ba17985114b7e3311a9af6924f15d85799dad72da44b728290e312f474', 'As it passed it set up an exultant deafening howl that drowned the
thunder—“Aloo! Aloo!”—and in another minute it was with its companion,
half a mile away, stooping over something in the field. I have no doubt
this Thing in the field was the third of the ten cylinders they had
fired at us from Mars.', 255, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('de3437a67c4d7693802f4984e02ba4a48effa34c814fec2c3f19896132f77a9a', 'For some minutes I lay there in the rain and darkness watching, by the
intermittent light, these monstrous beings of metal moving about in the
distance over the hedge tops. A thin hail was now beginning, and as it
came and went their figures grew misty and then flashed into clearness
again. Now and then came a gap in the lightning, and the night
swallowed them up.', 256, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1ad34c9fbaa2eccd2ef5117f0172da35fe14e0e3769c8b5151549c3ff75698db', 'I was soaked with hail above and puddle water below. It was some time
before my blank astonishment would let me struggle up the bank to a
drier position, or think at all of my imminent peril.', 257, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c5df21dd38b6726f101e3bb9c01e1050eadad5e7e0764008689e41f90e2c2314', 'Not far from me was a little one-roomed squatter’s hut of wood,
surrounded by a patch of potato garden. I struggled to my feet at last,
and, crouching and making use of every chance of cover, I made a run
for this. I hammered at the door, but I could not make the people hear
(if there were any people inside), and after a time I desisted, and,
availing myself of a ditch for the greater part of the way, succeeded
in crawling, unobserved by these monstrous machines, into the pine
woods towards Maybury.', 258, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('013bc84aeb4cdc725e4d647eaed329686217dcb388187b6f19a4b840b02e6489', 'Under cover of this I pushed on, wet and shivering now, towards my own
house. I walked among the trees trying to find the footpath. It was
very dark indeed in the wood, for the lightning was now becoming
infrequent, and the hail, which was pouring down in a torrent, fell in
columns through the gaps in the heavy foliage.', 259, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('60f3925918542e939630d6eda15e8f172c1b62aa557b1b3f306bcb2263a1eae0', 'If I had fully realised the meaning of all the things I had seen I
should have immediately worked my way round through Byfleet to Street
Cobham, and so gone back to rejoin my wife at Leatherhead. But that
night the strangeness of things about me, and my physical wretchedness,
prevented me, for I was bruised, weary, wet to the skin, deafened and
blinded by the storm.', 260, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('902326c6924bbdb4545cbbb0d81a8b0c4a7fe876835967502a981d1354fd5f92', 'I had a vague idea of going on to my own house, and that was as much
motive as I had. I staggered through the trees, fell into a ditch and
bruised my knees against a plank, and finally splashed out into the
lane that ran down from the College Arms. I say splashed, for the storm
water was sweeping the sand down the hill in a muddy torrent. There in
the darkness a man blundered into me and sent me reeling back.', 261, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('53022c4eeba7d6ab18abf75e81817624f5267e1c9ee7fbf0875750e670a0aaa6', '“I shall go on,” he said.', 335, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('773451477c60efdc86e69deca8b8864f56cb4339aaf7cc97945b6fb3a559af91', 'Near the top I stumbled upon something soft, and, by a flash of
lightning, saw between my feet a heap of black broadcloth and a pair of
boots. Before I could distinguish clearly how the man lay, the flicker
of light had passed. I stood over him waiting for the next flash. When
it came, I saw that he was a sturdy man, cheaply but not shabbily
dressed; his head was bent under his body, and he lay crumpled up close
to the fence, as though he had been flung violently against it.', 263, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6e5b8039007f4abdcee68f74aa2939e617aad12c42f923fdb95140b2d388e0ce', 'Overcoming the repugnance natural to one who had never before touched a
dead body, I stooped and turned him over to feel for his heart. He was
quite dead. Apparently his neck had been broken. The lightning flashed
for a third time, and his face leaped upon me. I sprang to my feet. It
was the landlord of the Spotted Dog, whose conveyance I had taken.', 264, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('37b5e572b747e41a75accaae5c7328863be5a466a348a1259d352e00bcfe2bd7', 'I stepped over him gingerly and pushed on up the hill. I made my way by
the police station and the College Arms towards my own house. Nothing
was burning on the hillside, though from the common there still came a
red glare and a rolling tumult of ruddy smoke beating up against the
drenching hail. So far as I could see by the flashes, the houses about
me were mostly uninjured. By the College Arms a dark heap lay in the
road.', 265, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('df968f31920807c41f478a177555260c5dfba74ec3df55acd722de9af0618472', 'Down the road towards Maybury Bridge there were voices and the sound of
feet, but I had not the courage to shout or to go to them. I let myself
in with my latchkey, closed, locked and bolted the door, staggered to
the foot of the staircase, and sat down. My imagination was full of
those striding metallic monsters, and of the dead body smashed against
the fence.', 266, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('80066c827d2665aad24846d894139944440c0db4cb61b0a889f2951c8bc49f7c', 'I crouched at the foot of the staircase with my back to the wall,
shivering violently.', 267, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e02ac95d776cbffa410fe7ddbada6965644805421fb5ba7c1c61466448388c40', '', 268, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4c53afdd258cdaaa0701deb7a975a38d742f34ff952bf2755d13b76543c1916c', '
XI.
AT THE WINDOW.', 269, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('08eee98ec42daf899b08d57fe285bbdf6136ea5581be8e4ff6aaf2256cda3fe7', '
I have already said that my storms of emotion have a trick of
exhausting themselves. After a time I discovered that I was cold and
wet, and with little pools of water about me on the stair carpet. I got
up almost mechanically, went into the dining room and drank some
whisky, and then I was moved to change my clothes.', 270, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6e3be2ef74a6b3df7c912563dda26829c7ebc8f319561129af2a8fd10217a0c0', 'After I had done that I went upstairs to my study, but why I did so I
do not know. The window of my study looks over the trees and the
railway towards Horsell Common. In the hurry of our departure this
window had been left open. The passage was dark, and, by contrast with
the picture the window frame enclosed, the side of the room seemed
impenetrably dark. I stopped short in the doorway.', 271, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6e19d057711a01db68de0db024b39813f69a4a1ee1dc7d2e7d67d8acd8db1d8a', 'The thunderstorm had passed. The towers of the Oriental College and the
pine trees about it had gone, and very far away, lit by a vivid red
glare, the common about the sand-pits was visible. Across the light
huge black shapes, grotesque and strange, moved busily to and fro.', 272, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fe42ebce01823d0b7661d07583885164fffe1e55e4aa39c79aa83ddaa45ad932', 'It seemed indeed as if the whole country in that direction was on
fire—a broad hillside set with minute tongues of flame, swaying and
writhing with the gusts of the dying storm, and throwing a red
reflection upon the cloud scud above. Every now and then a haze of
smoke from some nearer conflagration drove across the window and hid
the Martian shapes. I could not see what they were doing, nor the clear
form of them, nor recognise the black objects they were busied upon.
Neither could I see the nearer fire, though the reflections of it
danced on the wall and ceiling of the study. A sharp, resinous tang of
burning was in the air.', 273, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4143e5b37e39bfcd8581fa09368b617fc4e8f89143f1b88e2259b0149942aa5', 'I closed the door noiselessly and crept towards the window. As I did
so, the view opened out until, on the one hand, it reached to the
houses about Woking station, and on the other to the charred and
blackened pine woods of Byfleet. There was a light down below the hill,
on the railway, near the arch, and several of the houses along the
Maybury road and the streets near the station were glowing ruins. The
light upon the railway puzzled me at first; there were a black heap and
a vivid glare, and to the right of that a row of yellow oblongs. Then I
perceived this was a wrecked train, the fore part smashed and on fire,
the hinder carriages still upon the rails.', 274, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e9a446da2483a5f837729e72591106e4ceede08821d35d8610177e7df011f8ef', 'Between these three main centres of light—the houses, the train, and
the burning county towards Chobham—stretched irregular patches of dark
country, broken here and there by intervals of dimly glowing and
smoking ground. It was the strangest spectacle, that black expanse set
with fire. It reminded me, more than anything else, of the Potteries at
night. At first I could distinguish no people at all, though I peered
intently for them. Later I saw against the light of Woking station a
number of black figures hurrying one after the other across the line.', 275, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a420884b9ea64004cf9607733081744ea3566d7c55812dd5d24b6d343352cdbd', 'And this was the little world in which I had been living securely for
years, this fiery chaos! What had happened in the last seven hours I
still did not know; nor did I know, though I was beginning to guess,
the relation between these mechanical colossi and the sluggish lumps I
had seen disgorged from the cylinder. With a queer feeling of
impersonal interest I turned my desk chair to the window, sat down, and
stared at the blackened country, and particularly at the three gigantic
black things that were going to and fro in the glare about the
sand-pits.', 276, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('588bc702e57a9634369d5af42caacbd6f16d030eadce29ef045256f3a5247cb2', 'They seemed amazingly busy. I began to ask myself what they could be.
Were they intelligent mechanisms? Such a thing I felt was impossible.
Or did a Martian sit within each, ruling, directing, using, much as a
man’s brain sits and rules in his body? I began to compare the things
to human machines, to ask myself for the first time in my life how an
ironclad or a steam engine would seem to an intelligent lower animal.', 277, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('819b7c7595b2e86a8958cb5d14864b4c761b62a09d322dc830dae1d0bf05bf3b', 'The storm had left the sky clear, and over the smoke of the burning
land the little fading pinpoint of Mars was dropping into the west,
when a soldier came into my garden. I heard a slight scraping at the
fence, and rousing myself from the lethargy that had fallen upon me, I
looked down and saw him dimly, clambering over the palings. At the
sight of another human being my torpor passed, and I leaned out of the
window eagerly.', 278, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cbd64cf2de2152afd95ad1465c69febc1df738cb8f766be361955136c99cb458', '“Hist!” said I, in a whisper.', 279, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('addc47fd19c6f3845be8f675b455c15152976fb9b49c35c3634d3a7d8860310e', 'He stopped astride of the fence in doubt. Then he came over and across
the lawn to the corner of the house. He bent down and stepped softly.', 280, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c901fb6b287e980f650ee165e51ef9b436398b809628a028ce7024841b53fa2c', '“Who’s there?” he said, also whispering, standing under the window and
peering up.', 281, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8664bf9f7e6c2a1d4af2fc25fa0a17aa0f10ff20cf05d9803319bd08f67e32f6', '“Where are you going?” I asked.', 282, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b858c1411022ea9990394b1ae357688c9e3760efe44499daf035a1644f267601', '“God knows.”', 283, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('56c9427756d557aef03eac30102ff8664f04cbefcf124c1c9cacf7d0d48a2260', '“Are you trying to hide?”', 284, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dfbdec5f972db9995b2e3a1dbdbbe4bfa2e98c967dfade8e2ec9eb7d2f574b81', '“That’s it.”', 285, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('188f351e8e4087964a51b28be616209a93a91ca2e77df7cc52d0540b8131ceba', '“Come into the house,” I said.', 286, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('552f577992b2bd8ab60febb1453df8a64e0b026952e1aef23277580d4780bf3d', 'I went down, unfastened the door, and let him in, and locked the door
again. I could not see his face. He was hatless, and his coat was
unbuttoned.', 287, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1f1f8d66f81791227550af7641e1e6f8d5e2c414367270bcf71a1940fb2faf0e', '“My God!” he said, as I drew him in.', 288, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9333d5152ad64f7abf021efdb4e8e75841875f4faba38e1704c745b72b778e59', '“What has happened?” I asked.', 289, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6850b1340c428d19c555baf394dd470bb233c102accb4b7746a9b76901e6195c', '“What hasn’t?” In the obscurity I could see he made a gesture of
despair. “They wiped us out—simply wiped us out,” he repeated again and
again.', 290, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d684381249a3a7501226c1df2b396ba6c8336c7726804095b9ec61795ce3b498', 'He followed me, almost mechanically, into the dining room.', 291, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('18acdbde32edeabc46045c23b5cad20ff2cee2085f0c694e3bb6a646576fb801', '“Take some whisky,” I said, pouring out a stiff dose.', 292, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('99ba59aeea50f84fad4bcaf456190e287d2fbaee956b5dc572f586a4c45ff12b', 'He drank it. Then abruptly he sat down before the table, put his head
on his arms, and began to sob and weep like a little boy, in a perfect
passion of emotion, while I, with a curious forgetfulness of my own
recent despair, stood beside him, wondering.', 293, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8e29fdebc8bfc15b454676678c55b291b9e869a0d738c6570a33dc6eea02c330', 'It was a long time before he could steady his nerves to answer my
questions, and then he answered perplexingly and brokenly. He was a
driver in the artillery, and had only come into action about seven. At
that time firing was going on across the common, and it was said the
first party of Martians were crawling slowly towards their second
cylinder under cover of a metal shield.', 294, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d01f0da77d6f5120ae63bfe7f51be8b5634f6dc780c760110dac1fb47cf72d22', 'Later this shield staggered up on tripod legs and became the first of
the fighting-machines I had seen. The gun he drove had been unlimbered
near Horsell, in order to command the sand-pits, and its arrival it was
that had precipitated the action. As the limber gunners went to the
rear, his horse trod in a rabbit hole and came down, throwing him into
a depression of the ground. At the same moment the gun exploded behind
him, the ammunition blew up, there was fire all about him, and he found
himself lying under a heap of charred dead men and dead horses.', 295, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c6fa22fc48ef8938c1cfed194933fd26950091acbe6eb5d81af81db137b7e19f', '“I lay still,” he said, “scared out of my wits, with the fore quarter
of a horse atop of me. We’d been wiped out. And the smell—good God!
Like burnt meat! I was hurt across the back by the fall of the horse,
and there I had to lie until I felt better. Just like parade it had
been a minute before—then stumble, bang, swish!”', 296, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6a20c4b5c8e91a60860281323fec037edd7e9f4b246b573993ac99c998e5f745', '“Wiped out!” he said.', 297, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2415af06ef4349da75e651ebdb242906f77379c05c6e7bd095658d54d31a36c7', 'He had hid under the dead horse for a long time, peeping out furtively
across the common. The Cardigan men had tried a rush, in skirmishing
order, at the pit, simply to be swept out of existence. Then the
monster had risen to its feet and had begun to walk leisurely to and
fro across the common among the few fugitives, with its headlike hood
turning about exactly like the head of a cowled human being. A kind of
arm carried a complicated metallic case, about which green flashes
scintillated, and out of the funnel of this there smoked the Heat-Ray.', 298, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ceeadcaecdd5339716f16d736dac7e3eef6c65bc757db7bc7332dc31d623a00d', 'In a few minutes there was, so far as the soldier could see, not a
living thing left upon the common, and every bush and tree upon it that
was not already a blackened skeleton was burning. The hussars had been
on the road beyond the curvature of the ground, and he saw nothing of
them. He heard the Maxims rattle for a time and then become still. The
giant saved Woking station and its cluster of houses until the last;
then in a moment the Heat-Ray was brought to bear, and the town became
a heap of fiery ruins. Then the Thing shut off the Heat-Ray, and
turning its back upon the artilleryman, began to waddle away towards
the smouldering pine woods that sheltered the second cylinder. As it
did so a second glittering Titan built itself up out of the pit.', 299, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9fbb72827d753e7aa383269805af4b4a72fafebf37f1028de6df170046ded1dc', 'The second monster followed the first, and at that the artilleryman
began to crawl very cautiously across the hot heather ash towards
Horsell. He managed to get alive into the ditch by the side of the
road, and so escaped to Woking. There his story became ejaculatory. The
place was impassable. It seems there were a few people alive there,
frantic for the most part and many burned and scalded. He was turned
aside by the fire, and hid among some almost scorching heaps of broken
wall as one of the Martian giants returned. He saw this one pursue a
man, catch him up in one of its steely tentacles, and knock his head
against the trunk of a pine tree. At last, after nightfall, the
artilleryman made a rush for it and got over the railway embankment.', 300, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d48647ca13e93ff16f7ab4ee5ffabdd99c9a5bd3ec9e7987550cfdc0caf35bb3', 'Since then he had been skulking along towards Maybury, in the hope of
getting out of danger Londonward. People were hiding in trenches and
cellars, and many of the survivors had made off towards Woking village
and Send. He had been consumed with thirst until he found one of the
water mains near the railway arch smashed, and the water bubbling out
like a spring upon the road.', 301, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('876362780a1a5fa4ce6fb7eba33fe053ff4f11291545dbac3f93935088c099b7', 'That was the story I got from him, bit by bit. He grew calmer telling
me and trying to make me see the things he had seen. He had eaten no
food since midday, he told me early in his narrative, and I found some
mutton and bread in the pantry and brought it into the room. We lit no
lamp for fear of attracting the Martians, and ever and again our hands
would touch upon bread or meat. As he talked, things about us came
darkly out of the darkness, and the trampled bushes and broken rose
trees outside the window grew distinct. It would seem that a number of
men or animals had rushed across the lawn. I began to see his face,
blackened and haggard, as no doubt mine was also.', 302, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('401ee5f8821e56d3ec71770abef8676e90f1df3e1e0eebdc8c143d56398c82e0', 'When we had finished eating we went softly upstairs to my study, and I
looked again out of the open window. In one night the valley had become
a valley of ashes. The fires had dwindled now. Where flames had been
there were now streamers of smoke; but the countless ruins of shattered
and gutted houses and blasted and blackened trees that the night had
hidden stood out now gaunt and terrible in the pitiless light of dawn.
Yet here and there some object had had the luck to escape—a white
railway signal here, the end of a greenhouse there, white and fresh
amid the wreckage. Never before in the history of warfare had
destruction been so indiscriminate and so universal. And shining with
the growing light of the east, three of the metallic giants stood about
the pit, their cowls rotating as though they were surveying the
desolation they had made.', 303, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e7e77b760cc7e8aa8b44b4a8fef330bd1ead7110961ea6847a337e799848b52d', 'It seemed to me that the pit had been enlarged, and ever and again
puffs of vivid green vapour streamed up and out of it towards the
brightening dawn—streamed up, whirled, broke, and vanished.', 304, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f8f27d8032396fb3b05298fab1048d121a192709002ae5791052581022343ab2', 'Beyond were the pillars of fire about Chobham. They became pillars of
bloodshot smoke at the first touch of day.', 305, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('03edd33df5f2be05dc06a1773897097087065a7e88811c1f87bc50db642419f6', '', 306, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9adf6bda33ec42d350b04a28987306c35bbd48c5cbf2672ff474070a41ecd2f4', '
XII.
WHAT I SAW OF THE DESTRUCTION OF WEYBRIDGE AND SHEPPERTON.', 307, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('46ad1e82a7e79d0cefd679153f37033b605b6e7f222194bef1f79f9be7fdb26f', '
As the dawn grew brighter we withdrew from the window from which we had
watched the Martians, and went very quietly downstairs.', 308, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('59403046ca8e803fe5fb1ae2353296e33fb4e8ad7c5df41607876cf12ad110a8', 'The artilleryman agreed with me that the house was no place to stay in.
He proposed, he said, to make his way Londonward, and thence rejoin his
battery—No. 12, of the Horse Artillery. My plan was to return at once
to Leatherhead; and so greatly had the strength of the Martians
impressed me that I had determined to take my wife to Newhaven, and go
with her out of the country forthwith. For I already perceived clearly
that the country about London must inevitably be the scene of a
disastrous struggle before such creatures as these could be destroyed.', 309, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f53f9ddbfc0b21ed515afd67a59922b7a0724f513cbfdf52c4575a7f5debbb12', 'Between us and Leatherhead, however, lay the third cylinder, with its
guarding giants. Had I been alone, I think I should have taken my
chance and struck across country. But the artilleryman dissuaded me:
“It’s no kindness to the right sort of wife,” he said, “to make her a
widow”; and in the end I agreed to go with him, under cover of the
woods, northward as far as Street Cobham before I parted with him.
Thence I would make a big detour by Epsom to reach Leatherhead.', 310, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8915ea517a66c93963e09e6098d4e08b28a19dc038f17dbcabfed5a856b75fdf', 'I should have started at once, but my companion had been in active
service and he knew better than that. He made me ransack the house for
a flask, which he filled with whisky; and we lined every available
pocket with packets of biscuits and slices of meat. Then we crept out
of the house, and ran as quickly as we could down the ill-made road by
which I had come overnight. The houses seemed deserted. In the road lay
a group of three charred bodies close together, struck dead by the
Heat-Ray; and here and there were things that people had dropped—a
clock, a slipper, a silver spoon, and the like poor valuables. At the
corner turning up towards the post office a little cart, filled with
boxes and furniture, and horseless, heeled over on a broken wheel. A
cash box had been hastily smashed open and thrown under the debris.', 311, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1dcad19a14818096caae3c72b16854d15d15f716ea61c83210ae432fcdf5c777', 'Except the lodge at the Orphanage, which was still on fire, none of the
houses had suffered very greatly here. The Heat-Ray had shaved the
chimney tops and passed. Yet, save ourselves, there did not seem to be
a living soul on Maybury Hill. The majority of the inhabitants had
escaped, I suppose, by way of the Old Woking road—the road I had taken
when I drove to Leatherhead—or they had hidden.', 312, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('abb0643bdbaa1e407b886ae53e342cca3d8ae7f8e2fc9377924d03da0bf22112', 'Farther on towards Weybridge, just over the bridge, there were a number
of men in white fatigue jackets throwing up a long rampart, and more
guns behind.', 336, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d614abe92110d7519e2ec728119da05258900768ff33d8d2924b0a60a9e4bf95', 'We went down the lane, by the body of the man in black, sodden now from
the overnight hail, and broke into the woods at the foot of the hill.
We pushed through these towards the railway without meeting a soul. The
woods across the line were but the scarred and blackened ruins of
woods; for the most part the trees had fallen, but a certain proportion
still stood, dismal grey stems, with dark brown foliage instead of
green.', 313, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('be54f73c10179080753063ec054ef233fd1d09f07aa467b4255298a8434c4be1', 'On our side the fire had done no more than scorch the nearer trees; it
had failed to secure its footing. In one place the woodmen had been at
work on Saturday; trees, felled and freshly trimmed, lay in a clearing,
with heaps of sawdust by the sawing-machine and its engine. Hard by was
a temporary hut, deserted. There was not a breath of wind this morning,
and everything was strangely still. Even the birds were hushed, and as
we hurried along I and the artilleryman talked in whispers and looked
now and again over our shoulders. Once or twice we stopped to listen.', 314, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e48f345a6a33afc98d22b9b022d4704fbc55e79e8721256eabd5c17f9e6ed639', 'After a time we drew near the road, and as we did so we heard the
clatter of hoofs and saw through the tree stems three cavalry soldiers
riding slowly towards Woking. We hailed them, and they halted while we
hurried towards them. It was a lieutenant and a couple of privates of
the 8th Hussars, with a stand like a theodolite, which the artilleryman
told me was a heliograph.', 315, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a7e0ebc1764f637f60735d3dbe589901f96448ee3574051dc2065dd987f7a569', '“You are the first men I’ve seen coming this way this morning,” said
the lieutenant. “What’s brewing?”', 316, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c629dc8ed72c3d5e7cc6db966c228e7c8c7467e1a22199584a14120deab3c709', 'His voice and face were eager. The men behind him stared curiously. The
artilleryman jumped down the bank into the road and saluted.', 317, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dcc94c51254ef3c59e127771ca14bc5014300a0142328f8f9d353a76bc5ce700', '“Gun destroyed last night, sir. Have been hiding. Trying to rejoin
battery, sir. You’ll come in sight of the Martians, I expect, about
half a mile along this road.”', 318, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b8a0290bbdd81545c616ffb49e17822a4397bc0bfce95ccacf9fc9aa1e49a690', '“What the dickens are they like?” asked the lieutenant.', 319, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7e9b744f2107524c6295977d68ee9d24427eb9d8ff3a92c677b65f238442c8af', '“Giants in armour, sir. Hundred feet high. Three legs and a body like
’luminium, with a mighty great head in a hood, sir.”', 320, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ed00ccddf95981cacb17aa6c1903aa3fe1b486f5129a6c554e6c5e5030401a04', '“Get out!” said the lieutenant. “What confounded nonsense!”', 321, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1b47aa96b98293cde2183778b414082e1921b9001b23961fa702c486fd7fe1f8', '“You’ll see, sir. They carry a kind of box, sir, that shoots fire and
strikes you dead.”', 322, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('21f0b05e10a0368cfeb7ef76cb8a759a0e239794432ffea5d660ebf618487c51', '“What d’ye mean—a gun?”', 323, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('86b0bf3389673080b35c5242fa4efed1f480834280f5d3e16c4ce9fc84dbd821', '“No, sir,” and the artilleryman began a vivid account of the Heat-Ray.
Halfway through, the lieutenant interrupted him and looked up at me. I
was still standing on the bank by the side of the road.', 324, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3b37b71aa5ec197510596852d3d4c0892928d7b17f70c9aefb5cea894ab54f02', '“It’s perfectly true,” I said.', 325, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7141cd9ed0aaf865b105abd131cc22c09f2a7afa654160806fd4fcde8c5ca3b7', '“Well,” said the lieutenant, “I suppose it’s my business to see it too.
Look here”—to the artilleryman—“we’re detailed here clearing people out
of their houses. You’d better go along and report yourself to
Brigadier-General Marvin, and tell him all you know. He’s at Weybridge.
Know the way?”', 326, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('01c9b289b4c25f75eaea953bf073e0a75715f0af7ccfd644a2a2f363e155d52b', '“I do,” I said; and he turned his horse southward again.', 327, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('63846c26e4ac74421b02adb21600b03951488d0eb9cdb560066534caddb91c26', '“Half a mile, you say?” said he.', 328, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4928375188b3aed3b5d163d5f7cee3cb7556dccda200d1e276f792cf014ac39', '“At most,” I answered, and pointed over the treetops southward. He
thanked me and rode on, and we saw them no more.', 329, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('300d269c676a951836a8621e8b5d0c1f366a1e993c624d9e3d7a2d5e595f20ef', 'Farther along we came upon a group of three women and two children in
the road, busy clearing out a labourer’s cottage. They had got hold of
a little hand truck, and were piling it up with unclean-looking bundles
and shabby furniture. They were all too assiduously engaged to talk to
us as we passed.', 330, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a054b0f8ebdd6e76fe09e9781c3adb9aa0c23032a216301e469a1560fb190698', 'By Byfleet station we emerged from the pine trees, and found the
country calm and peaceful under the morning sunlight. We were far
beyond the range of the Heat-Ray there, and had it not been for the
silent desertion of some of the houses, the stirring movement of
packing in others, and the knot of soldiers standing on the bridge over
the railway and staring down the line towards Woking, the day would
have seemed very like any other Sunday.', 331, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('03fbf45dd50dd3cc7176603290f320697c4fb32c48f8e8f57fc7fb0bc75e1256', 'Several farm waggons and carts were moving creakily along the road to
Addlestone, and suddenly through the gate of a field we saw, across a
stretch of flat meadow, six twelve-pounders standing neatly at equal
distances pointing towards Woking. The gunners stood by the guns
waiting, and the ammunition waggons were at a business-like distance.
The men stood almost as if under inspection.', 332, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5294f8b94f4f9e144b113ff93e8700129b42e178df17a9af28b697e75492f8de', '“That’s good!” said I. “They will get one fair shot, at any rate.”', 333, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a22ccb262d09047100b854aef5cb8004601d3dd4405c71d06db2945f629499b8', 'The artilleryman hesitated at the gate.', 334, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fa6f2754ab6cd356534a0617a0b54a378d0d1bcb2b96fa15e2d8f7bde36d2b00', 'The officers who were not actively engaged stood and stared over the
treetops southwestward, and the men digging would stop every now and
again to stare in the same direction.', 338, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f447f7dada68882b86b6ffc80bdac45f9dbcb0c7c419c77654a9083730ed1397', 'Byfleet was in a tumult; people packing, and a score of hussars, some
of them dismounted, some on horseback, were hunting them about. Three
or four black government waggons, with crosses in white circles, and an
old omnibus, among other vehicles, were being loaded in the village
street. There were scores of people, most of them sufficiently
sabbatical to have assumed their best clothes. The soldiers were having
the greatest difficulty in making them realise the gravity of their
position. We saw one shrivelled old fellow with a huge box and a score
or more of flower pots containing orchids, angrily expostulating with
the corporal who would leave them behind. I stopped and gripped his
arm.', 339, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4592bd2ab2f6466ccb281cd7d62e1a29c37608235b36963c89b9117ba784804f', '“Do you know what’s over there?” I said, pointing at the pine tops that
hid the Martians.', 340, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9c54e94525ac56830620e9a308ea00b2442e7b36218e92c7cbfe549c08b35ff3', '“Eh?” said he, turning. “I was explainin’ these is vallyble.”', 341, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e715bd863c2cb2746985ee82701b19f78a10f1cfcec5cb4d8e0e13b7c0d5accd', '“Death!” I shouted. “Death is coming! Death!” and leaving him to digest
that if he could, I hurried on after the artillery-man. At the corner I
looked back. The soldier had left him, and he was still standing by his
box, with the pots of orchids on the lid of it, and staring vaguely
over the trees.', 342, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fee70221daa3c690e65679498405c558290a69d59387b241d1f7a0b266360a32', 'No one in Weybridge could tell us where the headquarters were
established; the whole place was in such confusion as I had never seen
in any town before. Carts, carriages everywhere, the most astonishing
miscellany of conveyances and horseflesh. The respectable inhabitants
of the place, men in golf and boating costumes, wives prettily dressed,
were packing, river-side loafers energetically helping, children
excited, and, for the most part, highly delighted at this astonishing
variation of their Sunday experiences. In the midst of it all the
worthy vicar was very pluckily holding an early celebration, and his
bell was jangling out above the excitement.', 343, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dbf3193ee1059000449b8b50ac861bd6b68d35d0614d29de43d1a412a6b10a0a', 'I and the artilleryman, seated on the step of the drinking fountain,
made a very passable meal upon what we had brought with us. Patrols of
soldiers—here no longer hussars, but grenadiers in white—were warning
people to move now or to take refuge in their cellars as soon as the
firing began. We saw as we crossed the railway bridge that a growing
crowd of people had assembled in and about the railway station, and the
swarming platform was piled with boxes and packages. The ordinary
traffic had been stopped, I believe, in order to allow of the passage
of troops and guns to Chertsey, and I have heard since that a savage
struggle occurred for places in the special trains that were put on at
a later hour.', 344, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e41746d071750a1b4bfb059102bbd267de50fd7acfa8a2336f564ff0cae314b', 'We remained at Weybridge until midday, and at that hour we found
ourselves at the place near Shepperton Lock where the Wey and Thames
join. Part of the time we spent helping two old women to pack a little
cart. The Wey has a treble mouth, and at this point boats are to be
hired, and there was a ferry across the river. On the Shepperton side
was an inn with a lawn, and beyond that the tower of Shepperton
Church—it has been replaced by a spire—rose above the trees.', 345, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cb06795d084cd49f0f07e4d568b1c075e02b4e898d046ad8feac3d9c94d26bd8', 'Here we found an excited and noisy crowd of fugitives. As yet the
flight had not grown to a panic, but there were already far more people
than all the boats going to and fro could enable to cross. People came
panting along under heavy burdens; one husband and wife were even
carrying a small outhouse door between them, with some of their
household goods piled thereon. One man told us he meant to try to get
away from Shepperton station.', 346, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c39b08e175bcc75f5794bfaa0ada603c434168598f25d189fdd82e29fe6005aa', 'There was a lot of shouting, and one man was even jesting. The idea
people seemed to have here was that the Martians were simply formidable
human beings, who might attack and sack the town, to be certainly
destroyed in the end. Every now and then people would glance nervously
across the Wey, at the meadows towards Chertsey, but everything over
there was still.', 347, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0536c37830d5df9663a33d71cf66549e745a0b1dda59a04822555731515e1b37', 'Across the Thames, except just where the boats landed, everything was
quiet, in vivid contrast with the Surrey side. The people who landed
there from the boats went tramping off down the lane. The big ferryboat
had just made a journey. Three or four soldiers stood on the lawn of
the inn, staring and jesting at the fugitives, without offering to
help. The inn was closed, as it was now within prohibited hours.', 348, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5e1ad78f713d9f5d81f285bf885d261bd92f6b4794cb69b7ca48c353fda61da2', '“What’s that?” cried a boatman, and “Shut up, you fool!” said a man
near me to a yelping dog. Then the sound came again, this time from the
direction of Chertsey, a muffled thud—the sound of a gun.', 349, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8e05c0d07df231ca6793e684b5477144c1fcf00c72e980d79b9d5be9c5d130e3', 'The fighting was beginning. Almost immediately unseen batteries across
the river to our right, unseen because of the trees, took up the
chorus, firing heavily one after the other. A woman screamed. Everyone
stood arrested by the sudden stir of battle, near us and yet invisible
to us. Nothing was to be seen save flat meadows, cows feeding
unconcernedly for the most part, and silvery pollard willows motionless
in the warm sunlight.', 350, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a5a037b87180e5140317a1a11406f77069ca2cdba65b0ea7a37791d795a90326', '“The sojers’ll stop ’em,” said a woman beside me, doubtfully. A
haziness rose over the treetops.', 351, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e49b15255af308da9a26998a44b1383974784f924a28e47a4d73819ed879c364', 'Then suddenly we saw a rush of smoke far away up the river, a puff of
smoke that jerked up into the air and hung; and forthwith the ground
heaved under foot and a heavy explosion shook the air, smashing two or
three windows in the houses near, and leaving us astonished.', 352, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a334e522030caab9d4beeacd34d0f143a28dc927accfa9d5954ae4aeb23de9e9', 'Quickly, one after the other, one, two, three, four of the armoured
Martians appeared, far away over the little trees, across the flat
meadows that stretched towards Chertsey, and striding hurriedly towards
the river. Little cowled figures they seemed at first, going with a
rolling motion and as fast as flying birds.', 354, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4f6713672c6a23912d68e7a94eabad9256e06380f4ed113a2df93ef1fbbd9c90', 'Then, advancing obliquely towards us, came a fifth. Their armoured
bodies glittered in the sun as they swept swiftly forward upon the
guns, growing rapidly larger as they drew nearer. One on the extreme
left, the remotest that is, flourished a huge case high in the air, and
the ghostly, terrible Heat-Ray I had already seen on Friday night smote
towards Chertsey, and struck the town.', 355, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4bbe93a0bb0694246bb0b377cffee7072a1cec1cc4948995a6a7a36df7eddadd', 'At sight of these strange, swift, and terrible creatures the crowd near
the water’s edge seemed to me to be for a moment horror-struck. There
was no screaming or shouting, but a silence. Then a hoarse murmur and a
movement of feet—a splashing from the water. A man, too frightened to
drop the portmanteau he carried on his shoulder, swung round and sent
me staggering with a blow from the corner of his burden. A woman thrust
at me with her hand and rushed past me. I turned with the rush of the
people, but I was not too terrified for thought. The terrible Heat-Ray
was in my mind. To get under water! That was it!', 356, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('173ac49cdd8b2ae0048891ede266d17f81bdbb2a6c55173306d61abe8ff21777', '“Get under water!” I shouted, unheeded.', 357, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('272b7076fb8497fc00c062f269d842eae12a7501709d7c9790bd3ee34cdfc116', 'I faced about again, and rushed towards the approaching Martian, rushed
right down the gravelly beach and headlong into the water. Others did
the same. A boatload of people putting back came leaping out as I
rushed past. The stones under my feet were muddy and slippery, and the
river was so low that I ran perhaps twenty feet scarcely waist-deep.
Then, as the Martian towered overhead scarcely a couple of hundred
yards away, I flung myself forward under the surface. The splashes of
the people in the boats leaping into the river sounded like
thunderclaps in my ears. People were landing hastily on both sides of
the river. But the Martian machine took no more notice for the moment
of the people running this way and that than a man would of the
confusion of ants in a nest against which his foot has kicked. When,
half suffocated, I raised my head above water, the Martian’s hood
pointed at the batteries that were still firing across the river, and
as it advanced it swung loose what must have been the generator of the
Heat-Ray.', 358, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3d6cd8ebe60eb3e6efdbe45c390c609e5d94ae19ad99006f95b0875757b82346', 'In another moment it was on the bank, and in a stride wading halfway
across. The knees of its foremost legs bent at the farther bank, and in
another moment it had raised itself to its full height again, close to
the village of Shepperton. Forthwith the six guns which, unknown to
anyone on the right bank, had been hidden behind the outskirts of that
village, fired simultaneously. The sudden near concussion, the last
close upon the first, made my heart jump. The monster was already
raising the case generating the Heat-Ray as the first shell burst six
yards above the hood.', 359, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('817cd8b9765d9d73aac1a3045f94881fae1949be796a80b8afba6ea4c1f55253', 'I gave a cry of astonishment. I saw and thought nothing of the other
four Martian monsters; my attention was riveted upon the nearer
incident. Simultaneously two other shells burst in the air near the
body as the hood twisted round in time to receive, but not in time to
dodge, the fourth shell.', 360, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('98b5457fdae9b27c38a52b964c59b88737203523c64d81a0546dab7238562590', 'The shell burst clean in the face of the Thing. The hood bulged,
flashed, was whirled off in a dozen tattered fragments of red flesh and
glittering metal.', 361, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c46ac4604cf74e49fbae35a565fb03e8194073b0e8ecd3a4bd261a460915fd1e', '“Hit!” shouted I, with something between a scream and a cheer.', 362, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d3453430b1b0d0dcd8c2d8beb1844a87d55146f529af1b02b573caad9d87d272', 'I heard answering shouts from the people in the water about me. I could
have leaped out of the water with that momentary exultation.', 363, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2bb2766e39ac2d0a337325b744fab0d829caf4430817b8bb4c8bae7f799d1313', 'The decapitated colossus reeled like a drunken giant; but it did not
fall over. It recovered its balance by a miracle, and, no longer
heeding its steps and with the camera that fired the Heat-Ray now
rigidly upheld, it reeled swiftly upon Shepperton. The living
intelligence, the Martian within the hood, was slain and splashed to
the four winds of heaven, and the Thing was now but a mere intricate
device of metal whirling to destruction. It drove along in a straight
line, incapable of guidance. It struck the tower of Shepperton Church,
smashing it down as the impact of a battering ram might have done,
swerved aside, blundered on and collapsed with tremendous force into
the river out of my sight.', 364, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('56206708f8144d4697007ae72d6245527669a1174b681cf89e2eae7574b15bf5', 'A violent explosion shook the air, and a spout of water, steam, mud,
and shattered metal shot far up into the sky. As the camera of the
Heat-Ray hit the water, the latter had immediately flashed into steam.
In another moment a huge wave, like a muddy tidal bore but almost
scaldingly hot, came sweeping round the bend upstream. I saw people
struggling shorewards, and heard their screaming and shouting faintly
above the seething and roar of the Martian’s collapse.', 365, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3d692645a4152394b92eac0ed75589d9fe43598fcf192c88417ee6771e710cfc', 'For a moment I heeded nothing of the heat, forgot the patent need of
self-preservation. I splashed through the tumultuous water, pushing
aside a man in black to do so, until I could see round the bend. Half a
dozen deserted boats pitched aimlessly upon the confusion of the waves.
The fallen Martian came into sight downstream, lying across the river,
and for the most part submerged.', 366, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0f6f6932c872f87d27806f9e48939b333475ff59deb8fa16c830c75fcca5094d', 'Thick clouds of steam were pouring off the wreckage, and through the
tumultuously whirling wisps I could see, intermittently and vaguely,
the gigantic limbs churning the water and flinging a splash and spray
of mud and froth into the air. The tentacles swayed and struck like
living arms, and, save for the helpless purposelessness of these
movements, it was as if some wounded thing were struggling for its life
amid the waves. Enormous quantities of a ruddy-brown fluid were
spurting up in noisy jets out of the machine.', 367, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4e656bd1ab481faefa24e7ec52a25369e8e652be8ad9bf3db2748f4952f89fda', 'My attention was diverted from this death flurry by a furious yelling,
like that of the thing called a siren in our manufacturing towns. A
man, knee-deep near the towing path, shouted inaudibly to me and
pointed. Looking back, I saw the other Martians advancing with gigantic
strides down the riverbank from the direction of Chertsey. The
Shepperton guns spoke this time unavailingly.', 368, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7b56bcafb10456630d8ca9c6d85deede01478a2046db65f9937147122e92f54b', 'At that I ducked at once under water, and, holding my breath until
movement was an agony, blundered painfully ahead under the surface as
long as I could. The water was in a tumult about me, and rapidly
growing hotter.', 369, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('38112645fbe980c8f76af6cdf3fc4902358b9788a407b9c8a2eb8eff02b56eaa', 'When for a moment I raised my head to take breath and throw the hair
and water from my eyes, the steam was rising in a whirling white fog
that at first hid the Martians altogether. The noise was deafening.
Then I saw them dimly, colossal figures of grey, magnified by the mist.
They had passed by me, and two were stooping over the frothing,
tumultuous ruins of their comrade.', 370, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ff4bf33ebb26ad4077b22b6ae9668ffb9710947fb6f379c1826908528c954241', 'The third and fourth stood beside him in the water, one perhaps two
hundred yards from me, the other towards Laleham. The generators of the
Heat-Rays waved high, and the hissing beams smote down this way and
that.', 371, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('074e5cb869474b1f547f522d7a236d0f4ad4c543016e5d8f93fa104728a858a3', 'The air was full of sound, a deafening and confusing conflict of
noises—the clangorous din of the Martians, the crash of falling houses,
the thud of trees, fences, sheds flashing into flame, and the crackling
and roaring of fire. Dense black smoke was leaping up to mingle with
the steam from the river, and as the Heat-Ray went to and fro over
Weybridge its impact was marked by flashes of incandescent white, that
gave place at once to a smoky dance of lurid flames. The nearer houses
still stood intact, awaiting their fate, shadowy, faint and pallid in
the steam, with the fire behind them going to and fro.', 372, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('58ae842d52feb0bb169783fe8ed9499b9e32fe9b5a290b9df428f6ac5364c219', 'For a moment perhaps I stood there, breast-high in the almost boiling
water, dumbfounded at my position, hopeless of escape. Through the reek
I could see the people who had been with me in the river scrambling out
of the water through the reeds, like little frogs hurrying through
grass from the advance of a man, or running to and fro in utter dismay
on the towing path.', 373, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('689220ac3300f673fef7506fe2888c8eda8d40569d22edef5a59881a1342cc03', 'Then suddenly the white flashes of the Heat-Ray came leaping towards
me. The houses caved in as they dissolved at its touch, and darted out
flames; the trees changed to fire with a roar. The Ray flickered up and
down the towing path, licking off the people who ran this way and that,
and came down to the water’s edge not fifty yards from where I stood.
It swept across the river to Shepperton, and the water in its track
rose in a boiling weal crested with steam. I turned shoreward.', 374, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c3ed091a5f9b1dbc236546c778f77b9e1e8a8babc886e7136aeb3d70c0f26b52', 'In another moment the huge wave, well-nigh at the boiling-point had
rushed upon me. I screamed aloud, and scalded, half blinded, agonised,
I staggered through the leaping, hissing water towards the shore. Had
my foot stumbled, it would have been the end. I fell helplessly, in
full sight of the Martians, upon the broad, bare gravelly spit that
runs down to mark the angle of the Wey and Thames. I expected nothing
but death.', 375, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a334d0217cbee9b7410b9a888f2f8d637f4781f6965999f7271f1c6a5913db3d', 'I have a dim memory of the foot of a Martian coming down within a score
of yards of my head, driving straight into the loose gravel, whirling
it this way and that and lifting again; of a long suspense, and then of
the four carrying the debris of their comrade between them, now clear
and then presently faint through a veil of smoke, receding
interminably, as it seemed to me, across a vast space of river and
meadow. And then, very slowly, I realised that by a miracle I had
escaped.', 376, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dbcd6f4836dae014ea7e9401f01b3944c045de8bb5bb11c966ae72141fbc55b4', '', 377, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7724a9e0bfa3a143c131ead47e6cc35a17858baa899c577ad4ada98f261e99d2', '
XIII.
HOW I FELL IN WITH THE CURATE.', 378, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6aa7d66dd123bb0c6454282b4bb86e221ab6eb6e6351ed3e60c12e2da9ab9d12', '
After getting this sudden lesson in the power of terrestrial weapons,
the Martians retreated to their original position upon Horsell Common;
and in their haste, and encumbered with the debris of their smashed
companion, they no doubt overlooked many such a stray and negligible
victim as myself. Had they left their comrade and pushed on forthwith,
there was nothing at that time between them and London but batteries of
twelve-pounder guns, and they would certainly have reached the capital
in advance of the tidings of their approach; as sudden, dreadful, and
destructive their advent would have been as the earthquake that
destroyed Lisbon a century ago.', 379, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('888a58d0092f26c7181e56727608267b43581adf9a55872c9ed2b48e0e782270', 'But they were in no hurry. Cylinder followed cylinder on its
interplanetary flight; every twenty-four hours brought them
reinforcement. And meanwhile the military and naval authorities, now
fully alive to the tremendous power of their antagonists, worked with
furious energy. Every minute a fresh gun came into position until,
before twilight, every copse, every row of suburban villas on the hilly
slopes about Kingston and Richmond, masked an expectant black muzzle.
And through the charred and desolated area—perhaps twenty square miles
altogether—that encircled the Martian encampment on Horsell Common,
through charred and ruined villages among the green trees, through the
blackened and smoking arcades that had been but a day ago pine
spinneys, crawled the devoted scouts with the heliographs that were
presently to warn the gunners of the Martian approach. But the Martians
now understood our command of artillery and the danger of human
proximity, and not a man ventured within a mile of either cylinder,
save at the price of his life.', 380, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6997b8e01eef3672a4faf3bff6f3f0c4adbf32a147d7ef9c3eb9f728f4e559a4', '“All the work—all the Sunday schools—What have we done—what has
Weybridge done? Everything gone—everything destroyed. The church! We
rebuilt it only three years ago. Gone! Swept out of existence! Why?”', 401, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cedfc9839e35a033dca02b18e6cf071495571a84db16a04f8f8508b96a89ef25', '
IX.
WRECKAGE.', 926, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('496f0601147eba34bf7828cd295f8d2370d1d867d963fabc9c04c887c1ef348b', 'It would seem that these giants spent the earlier part of the afternoon
in going to and fro, transferring everything from the second and third
cylinders—the second in Addlestone Golf Links and the third at
Pyrford—to their original pit on Horsell Common. Over that, above the
blackened heather and ruined buildings that stretched far and wide,
stood one as sentinel, while the rest abandoned their vast
fighting-machines and descended into the pit. They were hard at work
there far into the night, and the towering pillar of dense green smoke
that rose therefrom could be seen from the hills about Merrow, and
even, it is said, from Banstead and Epsom Downs.', 381, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('149b64e6607b19e39873dc44c18bac6f4c3b2847e7aba1dc367274c452c01df2', 'And while the Martians behind me were thus preparing for their next
sally, and in front of me Humanity gathered for the battle, I made my
way with infinite pains and labour from the fire and smoke of burning
Weybridge towards London.', 382, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('800006ffed5715e2c6d8501c77fd9b64429d2f9186af5ad54fc637af7def8f9b', 'I saw an abandoned boat, very small and remote, drifting down-stream;
and throwing off the most of my sodden clothes, I went after it, gained
it, and so escaped out of that destruction. There were no oars in the
boat, but I contrived to paddle, as well as my parboiled hands would
allow, down the river towards Halliford and Walton, going very
tediously and continually looking behind me, as you may well
understand. I followed the river, because I considered that the water
gave me my best chance of escape should these giants return.', 383, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1c41431095f1e6510fac068eb2b6b261a82c9fd1c18343e6d8c6981859403bee', 'The hot water from the Martian’s overthrow drifted downstream with me,
so that for the best part of a mile I could see little of either bank.
Once, however, I made out a string of black figures hurrying across the
meadows from the direction of Weybridge. Halliford, it seemed, was
deserted, and several of the houses facing the river were on fire. It
was strange to see the place quite tranquil, quite desolate under the
hot blue sky, with the smoke and little threads of flame going straight
up into the heat of the afternoon. Never before had I seen houses
burning without the accompaniment of an obstructive crowd. A little
farther on the dry reeds up the bank were smoking and glowing, and a
line of fire inland was marching steadily across a late field of hay.', 384, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('601f595de382e483bbb72e57bf562d1295528e8ec76ef5620b96d2fbc012ab79', 'For a long time I drifted, so painful and weary was I after the
violence I had been through, and so intense the heat upon the water.
Then my fears got the better of me again, and I resumed my paddling.
The sun scorched my bare back. At last, as the bridge at Walton was
coming into sight round the bend, my fever and faintness overcame my
fears, and I landed on the Middlesex bank and lay down, deadly sick,
amid the long grass. I suppose the time was then about four or five
o’clock. I got up presently, walked perhaps half a mile without meeting
a soul, and then lay down again in the shadow of a hedge. I seem to
remember talking, wanderingly, to myself during that last spurt. I was
also very thirsty, and bitterly regretful I had drunk no more water. It
is a curious thing that I felt angry with my wife; I cannot account for
it, but my impotent desire to reach Leatherhead worried me excessively.', 385, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4ed267cadd85b3801276b6be8407ad3d1828ebdf8da4d9b1a833b11900fed983', 'I do not clearly remember the arrival of the curate, so that probably I
dozed. I became aware of him as a seated figure in soot-smudged shirt
sleeves, and with his upturned, clean-shaven face staring at a faint
flickering that danced over the sky. The sky was what is called a
mackerel sky—rows and rows of faint down-plumes of cloud, just tinted
with the midsummer sunset.', 386, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('68627a7497ac991e7a0505b2f47e4c7b37e3875573300f0c836601891207ddca', 'I sat up, and at the rustle of my motion he looked at me quickly.', 387, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('476b5066ae101968c9349fa77cc86e0df707b527e57863db0c8355b64f128a54', '“Have you any water?” I asked abruptly.', 388, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('012e7093bbf3e75289b85876a2c8adc3480112755cdaddb7100cb061e052410d', 'He shook his head.', 389, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('844ce2ec7237e7e03c784c596d3d58bc9295b3465674346fcf83d2b49973ed65', '“You have been asking for water for the last hour,” he said.', 390, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('43862894d0b739fee6ce622f223a05528a884769c1355cdb17243671bdd064c0', 'For a moment we were silent, taking stock of each other. I dare say he
found me a strange enough figure, naked, save for my water-soaked
trousers and socks, scalded, and my face and shoulders blackened by the
smoke. His face was a fair weakness, his chin retreated, and his hair
lay in crisp, almost flaxen curls on his low forehead; his eyes were
rather large, pale blue, and blankly staring. He spoke abruptly,
looking vacantly away from me.', 391, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('79e9ae562d4739354771ddc104f1a3e334b9e14c8e748016daaa34d5538208de', '“What does it mean?” he said. “What do these things mean?”', 392, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('db5c73ea95b34f3d068646f26a677eda3468ba79d46c82f2335459077ac30303', 'I stared at him and made no answer.', 393, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fc0c3e1aacdbc3aada75554e16cb24cbfc92e71e98be10862cf4db821f34c5fd', 'He extended a thin white hand and spoke in almost a complaining tone.', 394, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('909fa008801ac51e75c74b2e3101a085f2c8d88377476dc7029135820d86a61b', '“Why are these things permitted? What sins have we done? The morning
service was over, I was walking through the roads to clear my brain for
the afternoon, and then—fire, earthquake, death! As if it were Sodom
and Gomorrah! All our work undone, all the work—— What are these
Martians?”', 395, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3c2c45cdfec341aaa5ccc7fe04f35e7088642238a2107cc3d319f7c946af80b0', '“What are we?” I answered, clearing my throat.', 396, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8b734782d4a5d55081d84a215acf2cca66ca1f6de215576f89bfe567e00e3d18', 'He gripped his knees and turned to look at me again. For half a minute,
perhaps, he stared silently.', 397, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0f41f4285361607a29a88f6d522586070ea400dda9f3f8e17602e6b581a7865f', '“I was walking through the roads to clear my brain,” he said. “And
suddenly—fire, earthquake, death!”', 398, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a8948d44d8c7ce43fd49fd878b8cffe60d5202250fca6d4456fddc476e15b697', 'Another pause, and he broke out again like one demented.', 402, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d5380f2814691314d4c626d147e072b57f1a6920dcb1f869141d13b48583c112', 'By this time I was beginning to take his measure. The tremendous
tragedy in which he had been involved—it was evident he was a fugitive
from Weybridge—had driven him to the very verge of his reason.', 405, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ca71e00cbadab299b2db70332ebf1c1ffc7c9bec9aa445e55556baac24904feb', '“Are we far from Sunbury?” I said, in a matter-of-fact tone.', 406, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d4b4b7f7dcc6e6f53638c0853ab187e45dcc3f7f12627ef0df76328a346de902', '“What are we to do?” he asked. “Are these creatures everywhere? Has the
earth been given over to them?”', 407, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('67559a3ec5d6d7b9885192a9fceba4a290f6fa4f0a7ab9621375f6969015e315', '“Are we far from Sunbury?”', 408, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b2c58fd1dc6921e3aae74bdde8f441204aab175774d79cf3c0fa78375227d412', '“Only this morning I officiated at early celebration——”', 409, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e3f30a322453d1d25392cf207e8a60787320ebf38c456a55f5f7eae3ad9de1d9', '“Things have changed,” I said, quietly. “You must keep your head. There
is still hope.”', 410, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('319dc60292a695a71634eecc8f2e553f27c3dbc2c906989cdae53cb89299c532', '“Hope!”', 411, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('85b64a340719ec6ba3c8ff3c9ef591943c2ef4abfebded0926b8b2d5f3a3878c', '“Yes. Plentiful hope—for all this destruction!”', 412, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e162530f20b711e6f0274925c437e7e66076ca4589fd6e25c58d50125cd731b1', 'I began to explain my view of our position. He listened at first, but
as I went on the interest dawning in his eyes gave place to their
former stare, and his regard wandered from me.', 413, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f866879835a4e8ff255daf4481be1b10df402e5c625e71f7499cf29c2226ef9d', '“This must be the beginning of the end,” he said, interrupting me. “The
end! The great and terrible day of the Lord! When men shall call upon
the mountains and the rocks to fall upon them and hide them—hide them
from the face of Him that sitteth upon the throne!”', 414, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8d941773239d7059d497c231518bec6969ff7322e862da017f6ef8e33ce56a66', 'I began to understand the position. I ceased my laboured reasoning,
struggled to my feet, and, standing over him, laid my hand on his
shoulder.', 415, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('841cde41adb39cbfcca6a39e86395469dc16f283a62f3dd2dfbb243a4174750f', '“Be a man!” said I. “You are scared out of your wits! What good is
religion if it collapses under calamity? Think of what earthquakes and
floods, wars and volcanoes, have done before to men! Did you think God
had exempted Weybridge? He is not an insurance agent.”', 416, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c4986d66ae539e706fdc085f571701ceab42a403fdeb877b3a6d2d6d850aa43a', 'For a time he sat in blank silence.', 417, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2062e09c7ca3413d931e54a9b73dd20a6ee7ff2a106d8971ff0732986f6fa867', '“But how can we escape?” he asked, suddenly. “They are invulnerable,
they are pitiless.”', 418, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cf309554124185d66f0ee7e82178b10733941f1e61ef66ee1aa78f82b3ab89db', '“Neither the one nor, perhaps, the other,” I answered. “And the
mightier they are the more sane and wary should we be. One of them was
killed yonder not three hours ago.”', 419, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('157fbbec66e21ca88988deeaba63c62a6ffbda767ec9a5a281ec519bc0aed4d4', '“Killed!” he said, staring about him. “How can God’s ministers be
killed?”', 420, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5831180730de813986f8080e88382cb87feda8ef08039c3012a2803c2d427729', '“I saw it happen.” I proceeded to tell him. “We have chanced to come in
for the thick of it,” said I, “and that is all.”', 421, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c03052949e00a8a59138cb50bd8a9b0025e67ccb606e4ffe08c2154e27dd1684', '“What is that flicker in the sky?” he asked abruptly.', 422, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e42ca83157459a1cc96dffc3b596095edd2f176649bd9c9d23bb6aab6ceb1546', 'I told him it was the heliograph signalling—that it was the sign of
human help and effort in the sky.', 423, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ebb870c64c9527e38633d8851982320f150dfd5d36dc655998d412460bc67d3b', '“We are in the midst of it,” I said, “quiet as it is. That flicker in
the sky tells of the gathering storm. Yonder, I take it are the
Martians, and Londonward, where those hills rise about Richmond and
Kingston and the trees give cover, earthworks are being thrown up and
guns are being placed. Presently the Martians will be coming this way
again.”', 424, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('42f6ad36d4170baf773cc599d2412f6f08b727d6211e203855b08a93db086f4f', 'And even as I spoke he sprang to his feet and stopped me by a gesture.', 425, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0434da42ab17c6f0aceacde44a0eb11c647f7ba4526a8bb2367a75e250bb99c3', '“Listen!” he said.', 426, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d8257fa986abc96a2ed1db859744ffbe49b2d4f8407a3350f9e7a15b0f610f09', 'From beyond the low hills across the water came the dull resonance of
distant guns and a remote weird crying. Then everything was still. A
cockchafer came droning over the hedge and past us. High in the west
the crescent moon hung faint and pale above the smoke of Weybridge and
Shepperton and the hot, still splendour of the sunset.', 427, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dbe67fbceb0c545c089378baa4765809c4a01a9f21e8307a58348a90f2a3d595', '“We had better follow this path,” I said, “northward.”', 428, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e105b8328c6d174666f3828a4b6351289773cc486335790fa96c4b719d04d752', '', 429, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f575f9380370b613d773a9721fe7ce36bc09f80a1131f83737de0b3a8470bd8d', '
XIV.
IN LONDON.', 430, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d2b182760b18222b8a0d3c2e9945cadb33dd8a8d275d8b93c073e9e9d445e165', '
My younger brother was in London when the Martians fell at Woking. He
was a medical student working for an imminent examination, and he heard
nothing of the arrival until Saturday morning. The morning papers on
Saturday contained, in addition to lengthy special articles on the
planet Mars, on life in the planets, and so forth, a brief and vaguely
worded telegram, all the more striking for its brevity.', 431, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2071040c8182a5af8436dd9aea136c6d713cf1900e3e24c2e5fc0a5bbf4f5643', 'The Martians, alarmed by the approach of a crowd, had killed a number
of people with a quick-firing gun, so the story ran. The telegram
concluded with the words: “Formidable as they seem to be, the Martians
have not moved from the pit into which they have fallen, and, indeed,
seem incapable of doing so. Probably this is due to the relative
strength of the earth’s gravitational energy.” On that last text their
leader-writer expanded very comfortingly.', 432, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('442bfa6ba19f4446d2dc36c88488339c14d0812c7639a4dc3a42cc2100e21e4e', 'Of course all the students in the crammer’s biology class, to which my
brother went that day, were intensely interested, but there were no
signs of any unusual excitement in the streets. The afternoon papers
puffed scraps of news under big headlines. They had nothing to tell
beyond the movements of troops about the common, and the burning of the
pine woods between Woking and Weybridge, until eight. Then the _St.
James’s Gazette_, in an extra-special edition, announced the bare fact
of the interruption of telegraphic communication. This was thought to
be due to the falling of burning pine trees across the line. Nothing
more of the fighting was known that night, the night of my drive to
Leatherhead and back.', 433, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8de2cc8385ba90a0b17ca858b15d8eaaf99a8cda0e8f03a667a716c07ed92090', 'My brother felt no anxiety about us, as he knew from the description in
the papers that the cylinder was a good two miles from my house. He
made up his mind to run down that night to me, in order, as he says, to
see the Things before they were killed. He dispatched a telegram, which
never reached me, about four o’clock, and spent the evening at a music
hall.', 434, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f37ec1125d690cff06c2937d79e9e049458e993f55c1656bf1915a9bbe070725', 'In London, also, on Saturday night there was a thunderstorm, and my
brother reached Waterloo in a cab. On the platform from which the
midnight train usually starts he learned, after some waiting, that an
accident prevented trains from reaching Woking that night. The nature
of the accident he could not ascertain; indeed, the railway authorities
did not clearly know at that time. There was very little excitement in
the station, as the officials, failing to realise that anything further
than a breakdown between Byfleet and Woking junction had occurred, were
running the theatre trains which usually passed through Woking round by
Virginia Water or Guildford. They were busy making the necessary
arrangements to alter the route of the Southampton and Portsmouth
Sunday League excursions. A nocturnal newspaper reporter, mistaking my
brother for the traffic manager, to whom he bears a slight resemblance,
waylaid and tried to interview him. Few people, excepting the railway
officials, connected the breakdown with the Martians.', 435, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5f5c8b78a2228a5d89c1d6be536b1ad3ff0060821a462b87df1777bf9e1452ee', 'I have read, in another account of these events, that on Sunday morning
“all London was electrified by the news from Woking.” As a matter of
fact, there was nothing to justify that very extravagant phrase. Plenty
of Londoners did not hear of the Martians until the panic of Monday
morning. Those who did took some time to realise all that the hastily
worded telegrams in the Sunday papers conveyed. The majority of people
in London do not read Sunday papers.', 436, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1a2fce73f1563c53ebf64a667aa5cd933c28319aa2c679846c5a6be5c5d3b02f', 'The habit of personal security, moreover, is so deeply fixed in the
Londoner’s mind, and startling intelligence so much a matter of course
in the papers, that they could read without any personal tremors:
“About seven o’clock last night the Martians came out of the cylinder,
and, moving about under an armour of metallic shields, have completely
wrecked Woking station with the adjacent houses, and massacred an
entire battalion of the Cardigan Regiment. No details are known. Maxims
have been absolutely useless against their armour; the field guns have
been disabled by them. Flying hussars have been galloping into
Chertsey. The Martians appear to be moving slowly towards Chertsey or
Windsor. Great anxiety prevails in West Surrey, and earthworks are
being thrown up to check the advance Londonward.” That was how the
_Sunday Sun_ put it, and a clever and remarkably prompt “handbook”
article in the _Referee_ compared the affair to a menagerie suddenly
let loose in a village.', 437, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('247af7b543c06275374a1d2b2edecb35ff3ce0d900041fec4ea83b1f6d15f83a', 'No one in London knew positively of the nature of the armoured
Martians, and there was still a fixed idea that these monsters must be
sluggish: “crawling,” “creeping painfully”—such expressions occurred in
almost all the earlier reports. None of the telegrams could have been
written by an eyewitness of their advance. The Sunday papers printed
separate editions as further news came to hand, some even in default of
it. But there was practically nothing more to tell people until late in
the afternoon, when the authorities gave the press agencies the news in
their possession. It was stated that the people of Walton and
Weybridge, and all the district were pouring along the roads
Londonward, and that was all.', 438, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b49350ad8442dd10ccb779b62c86f2e64e6597dc8df8d76bf23b66be39cf92d1', 'My brother went to church at the Foundling Hospital in the morning,
still in ignorance of what had happened on the previous night. There he
heard allusions made to the invasion, and a special prayer for peace.
Coming out, he bought a _Referee_. He became alarmed at the news in
this, and went again to Waterloo station to find out if communication
were restored. The omnibuses, carriages, cyclists, and innumerable
people walking in their best clothes seemed scarcely affected by the
strange intelligence that the newsvendors were disseminating. People
were interested, or, if alarmed, alarmed only on account of the local
residents. At the station he heard for the first time that the Windsor
and Chertsey lines were now interrupted. The porters told him that
several remarkable telegrams had been received in the morning from
Byfleet and Chertsey stations, but that these had abruptly ceased. My
brother could get very little precise detail out of them.', 439, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('62bad4d934fd004ea17a6c907028e707e0fdd18340912c1eccd947cc6b282cad', '“There’s fighting going on about Weybridge” was the extent of their
information.', 440, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('77650839bf949f276dd33734e1d4cf8f78c487813b783e1002d85dbe123905ee', 'The train service was now very much disorganised. Quite a number of
people who had been expecting friends from places on the South-Western
network were standing about the station. One grey-headed old gentleman
came and abused the South-Western Company bitterly to my brother. “It
wants showing up,” he said.', 441, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('43f0bb2c8085ae193fc715b6990fd84015ea737b2f8a35435967d81ff05272c8', '“Go back to the chaise,” said my brother, wiping the blood from his
split lip.', 536, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b2f9c56c115baf2d48a933c857ea99f15269af032ed882d18110a59807173510', 'One or two trains came in from Richmond, Putney, and Kingston,
containing people who had gone out for a day’s boating and found the
locks closed and a feeling of panic in the air. A man in a blue and
white blazer addressed my brother, full of strange tidings.', 442, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b15af904a97c484e4a8bd0480cf078efbfaca87ca2c3848684a4e040574632d6', '“There’s hosts of people driving into Kingston in traps and carts and
things, with boxes of valuables and all that,” he said. “They come from
Molesey and Weybridge and Walton, and they say there’s been guns heard
at Chertsey, heavy firing, and that mounted soldiers have told them to
get off at once because the Martians are coming. We heard guns firing
at Hampton Court station, but we thought it was thunder. What the
dickens does it all mean? The Martians can’t get out of their pit, can
they?”', 443, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7c8d91f3d4310d63aa0342497a2f681e75d3cbc807820bc377e18cd8875a007e', 'My brother could not tell him.', 444, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a6fb1e80b58050b406b1563d43fa768472997ff6a3d2dbc353d61720b978de26', 'Afterwards he found that the vague feeling of alarm had spread to the
clients of the underground railway, and that the Sunday excursionists
began to return from all over the South-Western “lung”—Barnes,
Wimbledon, Richmond Park, Kew, and so forth—at unnaturally early hours;
but not a soul had anything more than vague hearsay to tell of.
Everyone connected with the terminus seemed ill-tempered.', 445, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d01e99497aeb55ef4fbe78017bbad88b7cce47861b8e9f61ea2780b66c34e90f', 'About five o’clock the gathering crowd in the station was immensely
excited by the opening of the line of communication, which is almost
invariably closed, between the South-Eastern and the South-Western
stations, and the passage of carriage trucks bearing huge guns and
carriages crammed with soldiers. These were the guns that were brought
up from Woolwich and Chatham to cover Kingston. There was an exchange
of pleasantries: “You’ll get eaten!” “We’re the beast-tamers!” and so
forth. A little while after that a squad of police came into the
station and began to clear the public off the platforms, and my brother
went out into the street again.', 446, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5ef1fcb91b2418f6ebe304d142ded6bdc821281000df9ac3fa6cc24a547fc35b', 'The church bells were ringing for evensong, and a squad of Salvation
Army lassies came singing down Waterloo Road. On the bridge a number of
loafers were watching a curious brown scum that came drifting down the
stream in patches. The sun was just setting, and the Clock Tower and
the Houses of Parliament rose against one of the most peaceful skies it
is possible to imagine, a sky of gold, barred with long transverse
stripes of reddish-purple cloud. There was talk of a floating body. One
of the men there, a reservist he said he was, told my brother he had
seen the heliograph flickering in the west.', 447, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b55df784f618e27ab31b926349beaa2f77208d1de8d46a9232f9e9c827f350aa', 'In Wellington Street my brother met a couple of sturdy roughs who had
just been rushed out of Fleet Street with still-wet newspapers and
staring placards. “Dreadful catastrophe!” they bawled one to the other
down Wellington Street. “Fighting at Weybridge! Full description!
Repulse of the Martians! London in Danger!” He had to give threepence
for a copy of that paper.', 448, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2b035ec22204993aea37435c86918db00ff7ac3424cbd1cc311d536e81a6b89b', 'Then it was, and then only, that he realised something of the full
power and terror of these monsters. He learned that they were not
merely a handful of small sluggish creatures, but that they were minds
swaying vast mechanical bodies; and that they could move swiftly and
smite with such power that even the mightiest guns could not stand
against them.', 449, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9294e5cc1e06b07ed8d09fe2df412fd55b4c33f5bac4818f7cef0820e78d974d', 'They were described as “vast spiderlike machines, nearly a hundred feet
high, capable of the speed of an express train, and able to shoot out a
beam of intense heat.” Masked batteries, chiefly of field guns, had
been planted in the country about Horsell Common, and especially
between the Woking district and London. Five of the machines had been
seen moving towards the Thames, and one, by a happy chance, had been
destroyed. In the other cases the shells had missed, and the batteries
had been at once annihilated by the Heat-Rays. Heavy losses of soldiers
were mentioned, but the tone of the dispatch was optimistic.', 450, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('90c5d7479943e37ed25bb913d8391dde3fb385e3385b33ae679dbb9b62e03a0c', 'The Martians had been repulsed; they were not invulnerable. They had
retreated to their triangle of cylinders again, in the circle about
Woking. Signallers with heliographs were pushing forward upon them from
all sides. Guns were in rapid transit from Windsor, Portsmouth,
Aldershot, Woolwich—even from the north; among others, long wire-guns
of ninety-five tons from Woolwich. Altogether one hundred and sixteen
were in position or being hastily placed, chiefly covering London.
Never before in England had there been such a vast or rapid
concentration of military material.', 451, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b0fd2ba85bef0c785c98645b8c1c8fa5ce5f17b6e50d709da9a328a9fd091937', 'Any further cylinders that fell, it was hoped, could be destroyed at
once by high explosives, which were being rapidly manufactured and
distributed. No doubt, ran the report, the situation was of the
strangest and gravest description, but the public was exhorted to avoid
and discourage panic. No doubt the Martians were strange and terrible
in the extreme, but at the outside there could not be more than twenty
of them against our millions.', 452, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('50d990bd5c10dceeb10040a73bab763c8570148faa716d53e41d18fefdba17e5', 'The authorities had reason to suppose, from the size of the cylinders,
that at the outside there could not be more than five in each
cylinder—fifteen altogether. And one at least was disposed of—perhaps
more. The public would be fairly warned of the approach of danger, and
elaborate measures were being taken for the protection of the people in
the threatened southwestern suburbs. And so, with reiterated assurances
of the safety of London and the ability of the authorities to cope with
the difficulty, this quasi-proclamation closed.', 453, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a55bb2ca7dc606d0d70c70af3733e44194bcaae8c178b3e30cf832341375cc2a', 'This was printed in enormous type on paper so fresh that it was still
wet, and there had been no time to add a word of comment. It was
curious, my brother said, to see how ruthlessly the usual contents of
the paper had been hacked and taken out to give this place.', 454, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e67015c9dcb76d844d9d30b27359ae8f327395d0e91ddb8e59e5fd6b37cbca23', 'Text and Tagging Tags Heat Map', 32, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('9b6d39cea3a311893d58d06cae96dfd98704f4cb0b991f1d469b89ad725c549c', 'All down Wellington Street people could be seen fluttering out the pink
sheets and reading, and the Strand was suddenly noisy with the voices
of an army of hawkers following these pioneers. Men came scrambling off
buses to secure copies. Certainly this news excited people intensely,
whatever their previous apathy. The shutters of a map shop in the
Strand were being taken down, my brother said, and a man in his Sunday
raiment, lemon-yellow gloves even, was visible inside the window
hastily fastening maps of Surrey to the glass.', 455, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('48496e8ed55ea60ac50851ec4489095a6f08cecfbab2cee6ffedd8459f8d6880', 'Going on along the Strand to Trafalgar Square, the paper in his hand,
my brother saw some of the fugitives from West Surrey. There was a man
with his wife and two boys and some articles of furniture in a cart
such as greengrocers use. He was driving from the direction of
Westminster Bridge; and close behind him came a hay waggon with five or
six respectable-looking people in it, and some boxes and bundles. The
faces of these people were haggard, and their entire appearance
contrasted conspicuously with the Sabbath-best appearance of the people
on the omnibuses. People in fashionable clothing peeped at them out of
cabs. They stopped at the Square as if undecided which way to take, and
finally turned eastward along the Strand. Some way behind these came a
man in workday clothes, riding one of those old-fashioned tricycles
with a small front wheel. He was dirty and white in the face.', 456, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('63b2d7bccfaebf0ff264d5c0ade1c994c1f2b6640243d6857a900919bf15f45b', 'My brother turned down towards Victoria, and met a number of such
people. He had a vague idea that he might see something of me. He
noticed an unusual number of police regulating the traffic. Some of the
refugees were exchanging news with the people on the omnibuses. One was
professing to have seen the Martians. “Boilers on stilts, I tell you,
striding along like men.” Most of them were excited and animated by
their strange experience.', 457, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('41c77a56f3db05116b8a99153e12c328044f44a6430993d1af57858f7a035590', 'Beyond Victoria the public-houses were doing a lively trade with these
arrivals. At all the street corners groups of people were reading
papers, talking excitedly, or staring at these unusual Sunday visitors.
They seemed to increase as night drew on, until at last the roads, my
brother said, were like Epsom High Street on a Derby Day. My brother
addressed several of these fugitives and got unsatisfactory answers
from most.', 458, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7c47c24a6f109367ec8313ef9ca1daf389cd6a830cb65c1b8b1ceee0687975af', 'None of them could tell him any news of Woking except one man, who
assured him that Woking had been entirely destroyed on the previous
night.', 459, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f067268668d48518501a19b8c20c6d1c605bcff9d3a8672fe4edfc512a89c788', '“I come from Byfleet,” he said; “a man on a bicycle came through the
place in the early morning, and ran from door to door warning us to
come away. Then came soldiers. We went out to look, and there were
clouds of smoke to the south—nothing but smoke, and not a soul coming
that way. Then we heard the guns at Chertsey, and folks coming from
Weybridge. So I’ve locked up my house and come on.”', 460, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a93924984bba4c6ad056aa9858615976219e16226f4d81aa9fc0ec5ed5ba3d31', 'At that time there was a strong feeling in the streets that the
authorities were to blame for their incapacity to dispose of the
invaders without all this inconvenience.', 461, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0bf036f44ec7d4fbdfea1346ae4b4ab59e084be2abb9e3b9d7e04893831e34a4', 'About eight o’clock a noise of heavy firing was distinctly audible all
over the south of London. My brother could not hear it for the traffic
in the main thoroughfares, but by striking through the quiet back
streets to the river he was able to distinguish it quite plainly.', 462, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f4204af7a3ab7b8217c4f423ee21fe23d3390f6e849914394d67cabd63c7f9a7', 'He walked from Westminster to his apartments near Regent’s Park, about
two. He was now very anxious on my account, and disturbed at the
evident magnitude of the trouble. His mind was inclined to run, even as
mine had run on Saturday, on military details. He thought of all those
silent, expectant guns, of the suddenly nomadic countryside; he tried
to imagine “boilers on stilts” a hundred feet high.', 463, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7a0037f5798f3e9c9c2a49c9d976191e9c807981b8bf05689813d04369259cc0', 'There were one or two cartloads of refugees passing along Oxford
Street, and several in the Marylebone Road, but so slowly was the news
spreading that Regent Street and Portland Place were full of their
usual Sunday-night promenaders, albeit they talked in groups, and along
the edge of Regent’s Park there were as many silent couples “walking
out” together under the scattered gas lamps as ever there had been. The
night was warm and still, and a little oppressive; the sound of guns
continued intermittently, and after midnight there seemed to be sheet
lightning in the south.', 464, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('347fefc1418146a5f3853abaee02f4586657b52acaaebb4dc8ae33c531652d7d', 'He read and re-read the paper, fearing the worst had happened to me. He
was restless, and after supper prowled out again aimlessly. He returned
and tried in vain to divert his attention to his examination notes. He
went to bed a little after midnight, and was awakened from lurid dreams
in the small hours of Monday by the sound of door knockers, feet
running in the street, distant drumming, and a clamour of bells. Red
reflections danced on the ceiling. For a moment he lay astonished,
wondering whether day had come or the world gone mad. Then he jumped
out of bed and ran to the window.', 465, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('91438d1bfe1e6e7653b596e5ccaf82370f1936e94b6cdebf30b1a7f5e97cec01', 'His room was an attic and as he thrust his head out, up and down the
street there were a dozen echoes to the noise of his window sash, and
heads in every kind of night disarray appeared. Enquiries were being
shouted. “They are coming!” bawled a policeman, hammering at the door;
“the Martians are coming!” and hurried to the next door.', 466, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cb7281891acb68d261b6087c44cc0f251ee980a902c9c97fb9e1839926154e0c', 'The sound of drumming and trumpeting came from the Albany Street
Barracks, and every church within earshot was hard at work killing
sleep with a vehement disorderly tocsin. There was a noise of doors
opening, and window after window in the houses opposite flashed from
darkness into yellow illumination.', 467, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5b171660d9ce5e6b8cb93aad5ef13632dc89e4e5539a2f753a90f845ff6999d9', 'She turned without a word—they were both panting—and they went back to
where the lady in white struggled to hold back the frightened pony.', 537, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e492c65ecda5f567f567c97b2fcbcf2c1c21c6eed8232f984a32b62554d75af4', 'Up the street came galloping a closed carriage, bursting abruptly into
noise at the corner, rising to a clattering climax under the window,
and dying away slowly in the distance. Close on the rear of this came a
couple of cabs, the forerunners of a long procession of flying
vehicles, going for the most part to Chalk Farm station, where the
North-Western special trains were loading up, instead of coming down
the gradient into Euston.', 468, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('002684290c6513f7ed03edb260c824823552075347b6f49e0d2727dfe2641c24', 'For a long time my brother stared out of the window in blank
astonishment, watching the policemen hammering at door after door, and
delivering their incomprehensible message. Then the door behind him
opened, and the man who lodged across the landing came in, dressed only
in shirt, trousers, and slippers, his braces loose about his waist, his
hair disordered from his pillow.', 469, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('71781e7cf499d566319c03986666af2e4fbac0358fbb6d88da0966e9e8530aad', '“What the devil is it?” he asked. “A fire? What a devil of a row!”', 470, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4005a0ec8049b626077fc0034fdeb422851808dbd747cdb8d9b6cd89eae966b7', 'They both craned their heads out of the window, straining to hear what
the policemen were shouting. People were coming out of the side
streets, and standing in groups at the corners talking.', 471, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9944169c1e3e365bd1cfbefe13d36f13eb36ac093cccfdc087c5d9d545d92f37', '“What the devil is it all about?” said my brother’s fellow lodger.', 472, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c50338a31253163b4474080ea4b754e53774ebe032fdb46482eae6bfe01df57f', 'My brother answered him vaguely and began to dress, running with each
garment to the window in order to miss nothing of the growing
excitement. And presently men selling unnaturally early newspapers came
bawling into the street:', 473, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('06287c4435fd97ad77772e1130c5aa308fad5ead85ef04a8ff9053d44b7213b7', '“London in danger of suffocation! The Kingston and Richmond defences
forced! Fearful massacres in the Thames Valley!”', 474, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c71d4c2fcc09fc1ba8dc55a70a1fa7757d781cf143745eb56ccb6f3f0ce37e79', 'And all about him—in the rooms below, in the houses on each side and
across the road, and behind in the Park Terraces and in the hundred
other streets of that part of Marylebone, and the Westbourne Park
district and St. Pancras, and westward and northward in Kilburn and St.
John’s Wood and Hampstead, and eastward in Shoreditch and Highbury and
Haggerston and Hoxton, and, indeed, through all the vastness of London
from Ealing to East Ham—people were rubbing their eyes, and opening
windows to stare out and ask aimless questions, dressing hastily as the
first breath of the coming storm of Fear blew through the streets. It
was the dawn of the great panic. London, which had gone to bed on
Sunday night oblivious and inert, was awakened, in the small hours of
Monday morning, to a vivid sense of danger.', 475, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('35b31cf7787ebd7908e4b404a4f00da4ac8aa256ee7435c670adf7e36c9e640f', 'Unable from his window to learn what was happening, my brother went
down and out into the street, just as the sky between the parapets of
the houses grew pink with the early dawn. The flying people on foot and
in vehicles grew more numerous every moment. “Black Smoke!” he heard
people crying, and again “Black Smoke!” The contagion of such a
unanimous fear was inevitable. As my brother hesitated on the
door-step, he saw another newsvendor approaching, and got a paper
forthwith. The man was running away with the rest, and selling his
papers for a shilling each as he ran—a grotesque mingling of profit and
panic.', 476, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('42fc7a0822c1477b3c91be8f0a49dfbb2ff4637fb43a67dc744ead5665340fa4', 'And from this paper my brother read that catastrophic dispatch of the
Commander-in-Chief:', 477, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bb5610a0aaf1254cdbd74b12da25f8399a6acd86587bab8be112334d936c8d77', '“The Martians are able to discharge enormous clouds of a black and
poisonous vapour by means of rockets. They have smothered our
batteries, destroyed Richmond, Kingston, and Wimbledon, and are
advancing slowly towards London, destroying everything on the way. It
is impossible to stop them. There is no safety from the Black Smoke but
in instant flight.”', 478, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('38ee2d88770aa59cf3096298af6ec4388c99154e0e07d0b0d8dbbc58db359365', '
That was all, but it was enough. The whole population of the great
six-million city was stirring, slipping, running; presently it would be
pouring _en masse_ northward.', 479, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8f291d75d4085b14253b95fe6e7ff2c8987894c3882758296c01d7c8ccf5f325', '“Black Smoke!” the voices cried. “Fire!”', 480, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('76ebff1364ecaa8c5f05f4c55353c7e19489c12a82ff8bf37ad127083c20a2fe', 'The bells of the neighbouring church made a jangling tumult, a cart
carelessly driven smashed, amid shrieks and curses, against the water
trough up the street. Sickly yellow lights went to and fro in the
houses, and some of the passing cabs flaunted unextinguished lamps. And
overhead the dawn was growing brighter, clear and steady and calm.', 481, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3cd31cd15bceb627e5519f4dba82b0d7fdb2549b2cc4946dc28e414ceb087b09', 'He heard footsteps running to and fro in the rooms, and up and down
stairs behind him. His landlady came to the door, loosely wrapped in
dressing gown and shawl; her husband followed, ejaculating.', 482, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('67e585dacc751ad91ca2a65d64e91a51c2bca58848b103295654a3f22ecf3481', 'As my brother began to realise the import of all these things, he
turned hastily to his own room, put all his available money—some ten
pounds altogether—into his pockets, and went out again into the
streets.', 483, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b419c7a648cdfd6223f812b4ac19c9e6349153b6e9de19576dd473fc7549bfc3', '', 484, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('003d2be60d41053f9e7058c2e1b43615d5c7b05f58cd8ae91d29bb63dcfe39c9', '
XV.
WHAT HAD HAPPENED IN SURREY.', 485, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d442850f1e707fd8fd6720169ba055029e1b45e5955aa3fe5961b183dd85beaf', 'The robbers had evidently had enough of it. When my brother looked
again they were retreating.', 538, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3d8a68200f2edcc293aa6e9e296f79656493e7f1bfc74fe5e7bda14c48f6db52', '“I’ll sit here,” said my brother, “if I may”; and he got upon the empty
front seat. The lady looked over her shoulder.', 539, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('adc2113b0754ee2155bf14e06a60639177a80c90d3595277bb91a694ee8611d7', '
It was while the curate had sat and talked so wildly to me under the
hedge in the flat meadows near Halliford, and while my brother was
watching the fugitives stream over Westminster Bridge, that the
Martians had resumed the offensive. So far as one can ascertain from
the conflicting accounts that have been put forth, the majority of them
remained busied with preparations in the Horsell pit until nine that
night, hurrying on some operation that disengaged huge volumes of green
smoke.', 486, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('48918bb7df6007e6b429db7baff01b27b7734e6deed9143b50a79222a3af9312', 'But three certainly came out about eight o’clock and, advancing slowly
and cautiously, made their way through Byfleet and Pyrford towards
Ripley and Weybridge, and so came in sight of the expectant batteries
against the setting sun. These Martians did not advance in a body, but
in a line, each perhaps a mile and a half from his nearest fellow. They
communicated with one another by means of sirenlike howls, running up
and down the scale from one note to another.', 487, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8a44ff67d8017c51a3b0628be567af0b4401eaeaa186fbd2192d9f6926e9ca14', 'It was this howling and firing of the guns at Ripley and St. George’s
Hill that we had heard at Upper Halliford. The Ripley gunners,
unseasoned artillery volunteers who ought never to have been placed in
such a position, fired one wild, premature, ineffectual volley, and
bolted on horse and foot through the deserted village, while the
Martian, without using his Heat-Ray, walked serenely over their guns,
stepped gingerly among them, passed in front of them, and so came
unexpectedly upon the guns in Painshill Park, which he destroyed.', 488, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ad3909f9a4caef237194191cd75ca5c163ac9106807028e86e6c43039586a553', 'The St. George’s Hill men, however, were better led or of a better
mettle. Hidden by a pine wood as they were, they seem to have been
quite unsuspected by the Martian nearest to them. They laid their guns
as deliberately as if they had been on parade, and fired at about a
thousand yards’ range.', 489, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('53bfe69ceefc74a30e93332c07de4a0d661665ef01118c8221442771a53c6448', 'The shells flashed all round him, and he was seen to advance a few
paces, stagger, and go down. Everybody yelled together, and the guns
were reloaded in frantic haste. The overthrown Martian set up a
prolonged ululation, and immediately a second glittering giant,
answering him, appeared over the trees to the south. It would seem that
a leg of the tripod had been smashed by one of the shells. The whole of
the second volley flew wide of the Martian on the ground, and,
simultaneously, both his companions brought their Heat-Rays to bear on
the battery. The ammunition blew up, the pine trees all about the guns
flashed into fire, and only one or two of the men who were already
running over the crest of the hill escaped.', 490, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eb594b7862264068b7913753caf610c78ddad03cf81a9e77d21fcc5411a8ae20', 'After this it would seem that the three took counsel together and
halted, and the scouts who were watching them report that they remained
absolutely stationary for the next half hour. The Martian who had been
overthrown crawled tediously out of his hood, a small brown figure,
oddly suggestive from that distance of a speck of blight, and
apparently engaged in the repair of his support. About nine he had
finished, for his cowl was then seen above the trees again.', 491, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ff64ac56143a7a3cf6abc664b7b4e2a2055c80ac83dbe045a8d012ab4f943421', 'It was a few minutes past nine that night when these three sentinels
were joined by four other Martians, each carrying a thick black tube. A
similar tube was handed to each of the three, and the seven proceeded
to distribute themselves at equal distances along a curved line between
St. George’s Hill, Weybridge, and the village of Send, southwest of
Ripley.', 492, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1bbeee26f04ac34efb544de582ca80540057c708c2faf8020e03fdd268a25861', 'A dozen rockets sprang out of the hills before them so soon as they
began to move, and warned the waiting batteries about Ditton and Esher.
At the same time four of their fighting machines, similarly armed with
tubes, crossed the river, and two of them, black against the western
sky, came into sight of myself and the curate as we hurried wearily and
painfully along the road that runs northward out of Halliford. They
moved, as it seemed to us, upon a cloud, for a milky mist covered the
fields and rose to a third of their height.', 493, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8cecab001d736cbfca4460a15cd0d40098691ac7c017a88dd69f320f359e2fa3', 'At this sight the curate cried faintly in his throat, and began
running; but I knew it was no good running from a Martian, and I turned
aside and crawled through dewy nettles and brambles into the broad
ditch by the side of the road. He looked back, saw what I was doing,
and turned to join me.', 494, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6a09746517d201d6feb5d285a0234e65dd0cf64e45652fe23c0622e2c35de06f', 'The two halted, the nearer to us standing and facing Sunbury, the
remoter being a grey indistinctness towards the evening star, away
towards Staines.', 495, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e09416faaee2557d70b102b196b50f8c6162ec69e16c7455b247975f82ccbbc4', 'The occasional howling of the Martians had ceased; they took up their
positions in the huge crescent about their cylinders in absolute
silence. It was a crescent with twelve miles between its horns. Never
since the devising of gunpowder was the beginning of a battle so still.
To us and to an observer about Ripley it would have had precisely the
same effect—the Martians seemed in solitary possession of the darkling
night, lit only as it was by the slender moon, the stars, the afterglow
of the daylight, and the ruddy glare from St. George’s Hill and the
woods of Painshill.', 496, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2f8cbaf93bc68c8ec8131c8fa5d407a3540309f06736478efab14423f35e3480', 'But facing that crescent everywhere—at Staines, Hounslow, Ditton,
Esher, Ockham, behind hills and woods south of the river, and across
the flat grass meadows to the north of it, wherever a cluster of trees
or village houses gave sufficient cover—the guns were waiting. The
signal rockets burst and rained their sparks through the night and
vanished, and the spirit of all those watching batteries rose to a
tense expectation. The Martians had but to advance into the line of
fire, and instantly those motionless black forms of men, those guns
glittering so darkly in the early night, would explode into a
thunderous fury of battle.', 497, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8447467d450d3da9ca22cb5eed1ca48fead2f681d8974159293e2f3ca7591e7f', '“Give me the reins,” she said, and laid the whip along the pony’s side.
In another moment a bend in the road hid the three men from my
brother’s eyes.', 540, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8163ba33eb76e0cde1a32ec6d515e2e044651e1bb3702b7d88dd442009a7e85a', 'No doubt the thought that was uppermost in a thousand of those vigilant
minds, even as it was uppermost in mine, was the riddle—how much they
understood of us. Did they grasp that we in our millions were
organized, disciplined, working together? Or did they interpret our
spurts of fire, the sudden stinging of our shells, our steady
investment of their encampment, as we should the furious unanimity of
onslaught in a disturbed hive of bees? Did they dream they might
exterminate us? (At that time no one knew what food they needed.) A
hundred such questions struggled together in my mind as I watched that
vast sentinel shape. And in the back of my mind was the sense of all
the huge unknown and hidden forces Londonward. Had they prepared
pitfalls? Were the powder mills at Hounslow ready as a snare? Would the
Londoners have the heart and courage to make a greater Moscow of their
mighty province of houses?', 498, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4573b09c9c27e13e3f8c8fb5060210c7831bc8d7d1f2d5c604481e0c7d5b0f50', 'Then, after an interminable time, as it seemed to us, crouching and
peering through the hedge, came a sound like the distant concussion of
a gun. Another nearer, and then another. And then the Martian beside us
raised his tube on high and discharged it, gunwise, with a heavy report
that made the ground heave. The one towards Staines answered him. There
was no flash, no smoke, simply that loaded detonation.', 499, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5b8dee36869d92ce4f398cdf432e026a1ec360a2dbaed0ad76686c864bff968d', 'I was so excited by these heavy minute-guns following one another that
I so far forgot my personal safety and my scalded hands as to clamber
up into the hedge and stare towards Sunbury. As I did so a second
report followed, and a big projectile hurtled overhead towards
Hounslow. I expected at least to see smoke or fire, or some such
evidence of its work. But all I saw was the deep blue sky above, with
one solitary star, and the white mist spreading wide and low beneath.
And there had been no crash, no answering explosion. The silence was
restored; the minute lengthened to three.', 500, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('31ab3a7ac176cb885917bb494969d6bdba98b1e8d91d0c9fd3419c9f3767fd57', '“What has happened?” said the curate, standing up beside me.', 501, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fcef89a7424abc0bb39a5ba40a177d356050f182ac021e3f672979eed8b763c4', '“Heaven knows!” said I.', 502, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('65999b1e800c5f43ff2e52d6d4ffa939deb4ed04573a707a142fd6ce88b8c94d', 'A bat flickered by and vanished. A distant tumult of shouting began and
ceased. I looked again at the Martian, and saw he was now moving
eastward along the riverbank, with a swift, rolling motion.', 503, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fef294452f57a56a74453437829bf5927f715bfe9ad4d9b3ce52b1c3e81dee93', 'Every moment I expected the fire of some hidden battery to spring upon
him; but the evening calm was unbroken. The figure of the Martian grew
smaller as he receded, and presently the mist and the gathering night
had swallowed him up. By a common impulse we clambered higher. Towards
Sunbury was a dark appearance, as though a conical hill had suddenly
come into being there, hiding our view of the farther country; and
then, remoter across the river, over Walton, we saw another such
summit. These hill-like forms grew lower and broader even as we stared.', 504, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d82e90d5b19a9b9e4b6c73a4f186ddedd87f894a5dc3df0156dffc0592ee3dad', 'Moved by a sudden thought, I looked northward, and there I perceived a
third of these cloudy black kopjes had risen.', 505, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('79d6d5aec79e2522865f5c0074ab66585fddc94700e5fd5bba123b396d4c50a3', 'Everything had suddenly become very still. Far away to the southeast,
marking the quiet, we heard the Martians hooting to one another, and
then the air quivered again with the distant thud of their guns. But
the earthly artillery made no reply.', 506, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c72117add96ded74ac268d7b910286e99eae0940d5929eeb784182305398c77e', 'Now at the time we could not understand these things, but later I was
to learn the meaning of these ominous kopjes that gathered in the
twilight. Each of the Martians, standing in the great crescent I have
described, had discharged, by means of the gunlike tube he carried, a
huge canister over whatever hill, copse, cluster of houses, or other
possible cover for guns, chanced to be in front of him. Some fired only
one of these, some two—as in the case of the one we had seen; the one
at Ripley is said to have discharged no fewer than five at that time.
These canisters smashed on striking the ground—they did not explode—and
incontinently disengaged an enormous volume of heavy, inky vapour,
coiling and pouring upward in a huge and ebony cumulus cloud, a gaseous
hill that sank and spread itself slowly over the surrounding country.
And the touch of that vapour, the inhaling of its pungent wisps, was
death to all that breathes.', 507, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fe17bbb88d1190de33b31b6176e6debf440c99486aad78accd6791b6fd136998', 'It was heavy, this vapour, heavier than the densest smoke, so that,
after the first tumultuous uprush and outflow of its impact, it sank
down through the air and poured over the ground in a manner rather
liquid than gaseous, abandoning the hills, and streaming into the
valleys and ditches and watercourses even as I have heard the
carbonic-acid gas that pours from volcanic clefts is wont to do. And
where it came upon water some chemical action occurred, and the surface
would be instantly covered with a powdery scum that sank slowly and
made way for more. The scum was absolutely insoluble, and it is a
strange thing, seeing the instant effect of the gas, that one could
drink without hurt the water from which it had been strained. The
vapour did not diffuse as a true gas would do. It hung together in
banks, flowing sluggishly down the slope of the land and driving
reluctantly before the wind, and very slowly it combined with the mist
and moisture of the air, and sank to the earth in the form of dust.
Save that an unknown element giving a group of four lines in the blue
of the spectrum is concerned, we are still entirely ignorant of the
nature of this substance.', 508, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e775998aca67203737333e12904a7e7569b4f303bc2a9b301068a06f711b3083', 'Once the tumultuous upheaval of its dispersion was over, the black
smoke clung so closely to the ground, even before its precipitation,
that fifty feet up in the air, on the roofs and upper stories of high
houses and on great trees, there was a chance of escaping its poison
altogether, as was proved even that night at Street Cobham and Ditton.', 509, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6016c6ce891bbd522c4a8a36927034638b58c5fd5884b7e7659d01b2c1ae6a52', 'So, quite unexpectedly, my brother found himself, panting, with a cut
mouth, a bruised jaw, and bloodstained knuckles, driving along an
unknown lane with these two women.', 541, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4626879c618769e26bdd1764f60bce53aba3c5a824ccf7a4a357121d45780f99', 'The man who escaped at the former place tells a wonderful story of the
strangeness of its coiling flow, and how he looked down from the church
spire and saw the houses of the village rising like ghosts out of its
inky nothingness. For a day and a half he remained there, weary,
starving and sun-scorched, the earth under the blue sky and against the
prospect of the distant hills a velvet-black expanse, with red roofs,
green trees, and, later, black-veiled shrubs and gates, barns,
outhouses, and walls, rising here and there into the sunlight.', 510, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('33399f6578d4aae7eb44b2eaa609ff20856fd3ef586d702c1fe41b6ee453195b', 'But that was at Street Cobham, where the black vapour was allowed to
remain until it sank of its own accord into the ground. As a rule the
Martians, when it had served its purpose, cleared the air of it again
by wading into it and directing a jet of steam upon it.', 511, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b5ab6cc99f043ede9ace8e8d273837179bd193e2b0c443fb586eb39e6b8aec19', 'This they did with the vapour banks near us, as we saw in the starlight
from the window of a deserted house at Upper Halliford, whither we had
returned. From there we could see the searchlights on Richmond Hill and
Kingston Hill going to and fro, and about eleven the windows rattled,
and we heard the sound of the huge siege guns that had been put in
position there. These continued intermittently for the space of a
quarter of an hour, sending chance shots at the invisible Martians at
Hampton and Ditton, and then the pale beams of the electric light
vanished, and were replaced by a bright red glow.', 512, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e135d8d48a700c4fd93c04fc30ecb10832a2a069c69c0cc04db73dabee1a87a', 'Then the fourth cylinder fell—a brilliant green meteor—as I learned
afterwards, in Bushey Park. Before the guns on the Richmond and
Kingston line of hills began, there was a fitful cannonade far away in
the southwest, due, I believe, to guns being fired haphazard before the
black vapour could overwhelm the gunners.', 513, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('70dfe0b8b10568b1ff9eab7b0611622f3bde458f7a6b2c5796af5fce9df1d456', 'So, setting about it as methodically as men might smoke out a wasps’
nest, the Martians spread this strange stifling vapour over the
Londonward country. The horns of the crescent slowly moved apart, until
at last they formed a line from Hanwell to Coombe and Malden. All night
through their destructive tubes advanced. Never once, after the Martian
at St. George’s Hill was brought down, did they give the artillery the
ghost of a chance against them. Wherever there was a possibility of
guns being laid for them unseen, a fresh canister of the black vapour
was discharged, and where the guns were openly displayed the Heat-Ray
was brought to bear.', 514, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('38a70814b363c960a233e15e09cd3e3236adcd17037d5f2f9380c4e6e5939e68', 'By midnight the blazing trees along the slopes of Richmond Park and the
glare of Kingston Hill threw their light upon a network of black smoke,
blotting out the whole valley of the Thames and extending as far as the
eye could reach. And through this two Martians slowly waded, and turned
their hissing steam jets this way and that.', 515, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9f042a7bb0edf6850ef141943a4a1b3a475976e7791fc2a09baa68873c7d03b9', 'They were sparing of the Heat-Ray that night, either because they had
but a limited supply of material for its production or because they did
not wish to destroy the country but only to crush and overawe the
opposition they had aroused. In the latter aim they certainly
succeeded. Sunday night was the end of the organised opposition to
their movements. After that no body of men would stand against them, so
hopeless was the enterprise. Even the crews of the torpedo-boats and
destroyers that had brought their quick-firers up the Thames refused to
stop, mutinied, and went down again. The only offensive operation men
ventured upon after that night was the preparation of mines and
pitfalls, and even in that their energies were frantic and spasmodic.', 516, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b2a942a559d482f45a67a9a0bba1930c6d121484ce26c0a7d30c4deeba99fa1f', 'One has to imagine, as well as one may, the fate of those batteries
towards Esher, waiting so tensely in the twilight. Survivors there were
none. One may picture the orderly expectation, the officers alert and
watchful, the gunners ready, the ammunition piled to hand, the limber
gunners with their horses and waggons, the groups of civilian
spectators standing as near as they were permitted, the evening
stillness, the ambulances and hospital tents with the burned and
wounded from Weybridge; then the dull resonance of the shots the
Martians fired, and the clumsy projectile whirling over the trees and
houses and smashing amid the neighbouring fields.', 517, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('be01e4416ffc43bdaf6c8a484035c0b8e9b4c9ba4b6a1144fce5418b178a7286', 'One may picture, too, the sudden shifting of the attention, the swiftly
spreading coils and bellyings of that blackness advancing headlong,
towering heavenward, turning the twilight to a palpable darkness, a
strange and horrible antagonist of vapour striding upon its victims,
men and horses near it seen dimly, running, shrieking, falling
headlong, shouts of dismay, the guns suddenly abandoned, men choking
and writhing on the ground, and the swift broadening-out of the opaque
cone of smoke. And then night and extinction—nothing but a silent mass
of impenetrable vapour hiding its dead.', 518, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('247dc35e6729fdb94acdc9996ac117ad4d830835cfc5f9e6031c133c542a2b90', 'Before dawn the black vapour was pouring through the streets of
Richmond, and the disintegrating organism of government was, with a
last expiring effort, rousing the population of London to the necessity
of flight.', 519, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b4c66c1d2b68d49d3d524732429d7dbf1c14fcfc57805cf47e1ac1ded457932c', '', 520, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('537b3576461021fccbe8dd95f6c09739dcdfe41f8691245113cdf56b0474445e', '
XVI.
THE EXODUS FROM LONDON.', 521, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fe711ea743d24ed1f8e367d77efcc97be792d61064f008f3309a69eb0670b355', '
So you understand the roaring wave of fear that swept through the
greatest city in the world just as Monday was dawning—the stream of
flight rising swiftly to a torrent, lashing in a foaming tumult round
the railway stations, banked up into a horrible struggle about the
shipping in the Thames, and hurrying by every available channel
northward and eastward. By ten o’clock the police organisation, and by
midday even the railway organisations, were losing coherency, losing
shape and efficiency, guttering, softening, running at last in that
swift liquefaction of the social body.', 522, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9b96fdae6f4ebf730f941a0865af281d8ccd5730661014fc00457ec3420bf775', '“I can’t go on! I can’t go on!”', 575, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a8ac9ecf775a76ccc05300a45a42a360aa8400b080bcd4b013c5d71227fde397', 'All the railway lines north of the Thames and the South-Eastern people
at Cannon Street had been warned by midnight on Sunday, and trains were
being filled. People were fighting savagely for standing-room in the
carriages even at two o’clock. By three, people were being trampled and
crushed even in Bishopsgate Street, a couple of hundred yards or more
from Liverpool Street station; revolvers were fired, people stabbed,
and the policemen who had been sent to direct the traffic, exhausted
and infuriated, were breaking the heads of the people they were called
out to protect.', 523, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c0db38830c1a8021059979dbbdc7d43e1d05640219c64d73da9869a62ca0b747', 'And as the day advanced and the engine drivers and stokers refused to
return to London, the pressure of the flight drove the people in an
ever-thickening multitude away from the stations and along the
northward-running roads. By midday a Martian had been seen at Barnes,
and a cloud of slowly sinking black vapour drove along the Thames and
across the flats of Lambeth, cutting off all escape over the bridges in
its sluggish advance. Another bank drove over Ealing, and surrounded a
little island of survivors on Castle Hill, alive, but unable to escape.', 524, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2da9e7ec47a1c6a2a96661c5ea6b796135d54b78e33fcf2baabebb1661d973b2', 'After a fruitless struggle to get aboard a North-Western train at Chalk
Farm—the engines of the trains that had loaded in the goods yard there
_ploughed_ through shrieking people, and a dozen stalwart men fought to
keep the crowd from crushing the driver against his furnace—my brother
emerged upon the Chalk Farm road, dodged across through a hurrying
swarm of vehicles, and had the luck to be foremost in the sack of a
cycle shop. The front tire of the machine he got was punctured in
dragging it through the window, but he got up and off, notwithstanding,
with no further injury than a cut wrist. The steep foot of Haverstock
Hill was impassable owing to several overturned horses, and my brother
struck into Belsize Road.', 525, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6aadeb178dbba9feabd9460ee8d3a0543cd597efafaa0469da736836f6337113', 'So he got out of the fury of the panic, and, skirting the Edgware Road,
reached Edgware about seven, fasting and wearied, but well ahead of the
crowd. Along the road people were standing in the roadway, curious,
wondering. He was passed by a number of cyclists, some horsemen, and
two motor cars. A mile from Edgware the rim of the wheel broke, and the
machine became unridable. He left it by the roadside and trudged
through the village. There were shops half opened in the main street of
the place, and people crowded on the pavement and in the doorways and
windows, staring astonished at this extraordinary procession of
fugitives that was beginning. He succeeded in getting some food at an
inn.', 526, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7a4d1b76d565dd96066d3026ce60430070ff2b90714d643a5588b8ef1599c38e', 'For a time he remained in Edgware not knowing what next to do. The
flying people increased in number. Many of them, like my brother,
seemed inclined to loiter in the place. There was no fresh news of the
invaders from Mars.', 527, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('40b3f337a013a3ab5679a6845b31ace25651a50878696d13b0d2f95b1f9bec0d', 'At that time the road was crowded, but as yet far from congested. Most
of the fugitives at that hour were mounted on cycles, but there were
soon motor cars, hansom cabs, and carriages hurrying along, and the
dust hung in heavy clouds along the road to St. Albans.', 528, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1827a71435e80535a07a8a14f81b0e44da5b2a83ff669098ec7b3314e2fb671b', 'It was perhaps a vague idea of making his way to Chelmsford, where some
friends of his lived, that at last induced my brother to strike into a
quiet lane running eastward. Presently he came upon a stile, and,
crossing it, followed a footpath northeastward. He passed near several
farmhouses and some little places whose names he did not learn. He saw
few fugitives until, in a grass lane towards High Barnet, he happened
upon two ladies who became his fellow travellers. He came upon them
just in time to save them.', 529, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d2aeca1ebd06bcc7646f6fd837d49b6be37b964d6590dc9b0a8b34616ef9e51', 'He heard their screams, and, hurrying round the corner, saw a couple of
men struggling to drag them out of the little pony-chaise in which they
had been driving, while a third with difficulty held the frightened
pony’s head. One of the ladies, a short woman dressed in white, was
simply screaming; the other, a dark, slender figure, slashed at the man
who gripped her arm with a whip she held in her disengaged hand.', 530, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e32a724b7f20888b462a440461ca3ceba564213769d0fc027e212651ff10f57e', 'My brother immediately grasped the situation, shouted, and hurried
towards the struggle. One of the men desisted and turned towards him,
and my brother, realising from his antagonist’s face that a fight was
unavoidable, and being an expert boxer, went into him forthwith and
sent him down against the wheel of the chaise.', 531, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3b5fa49bddb39eb4267c670de695a3c787c3653fa795baa7996712c9b871b8af', 'It was no time for pugilistic chivalry and my brother laid him quiet
with a kick, and gripped the collar of the man who pulled at the
slender lady’s arm. He heard the clatter of hoofs, the whip stung
across his face, a third antagonist struck him between the eyes, and
the man he held wrenched himself free and made off down the lane in the
direction from which he had come.', 532, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dac5edfb060b8d79c36e555cde05c8b6cc21118d687495d9ea84d2aec3bf46d1', 'Partly stunned, he found himself facing the man who had held the
horse’s head, and became aware of the chaise receding from him down the
lane, swaying from side to side, and with the women in it looking back.
The man before him, a burly rough, tried to close, and he stopped him
with a blow in the face. Then, realising that he was deserted, he
dodged round and made off down the lane after the chaise, with the
sturdy man close behind him, and the fugitive, who had turned now,
following remotely.', 533, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('847a65223e695bc55f008e07997d3463862478ec656c48ff5ce6a7aeb72d3282', 'Suddenly he stumbled and fell; his immediate pursuer went headlong, and
he rose to his feet to find himself with a couple of antagonists again.
He would have had little chance against them had not the slender lady
very pluckily pulled up and returned to his help. It seems she had had
a revolver all this time, but it had been under the seat when she and
her companion were attacked. She fired at six yards’ distance, narrowly
missing my brother. The less courageous of the robbers made off, and
his companion followed him, cursing his cowardice. They both stopped in
sight down the lane, where the third man lay insensible.', 534, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('692a31acefbd90b01f4ff2f362dc35511d3c1b7e58784ed29ca5b80d6759185c', '“Take this!” said the slender lady, and she gave my brother her
revolver.', 535, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('932d9a575b527a5814a29340a6429534a3a9c3450a8e4186247789c1a9c5c9aa', 'He learned they were the wife and the younger sister of a surgeon
living at Stanmore, who had come in the small hours from a dangerous
case at Pinner, and heard at some railway station on his way of the
Martian advance. He had hurried home, roused the women—their servant
had left them two days before—packed some provisions, put his revolver
under the seat—luckily for my brother—and told them to drive on to
Edgware, with the idea of getting a train there. He stopped behind to
tell the neighbours. He would overtake them, he said, at about half
past four in the morning, and now it was nearly nine and they had seen
nothing of him. They could not stop in Edgware because of the growing
traffic through the place, and so they had come into this side lane.', 542, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9f3eedcb772f06a41152230fd9b87824dc9ab7991397ec39bb59055e1d4ed6cb', 'That was the story they told my brother in fragments when presently
they stopped again, nearer to New Barnet. He promised to stay with
them, at least until they could determine what to do, or until the
missing man arrived, and professed to be an expert shot with the
revolver—a weapon strange to him—in order to give them confidence.', 543, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('91e742be17dc6854594c09952600a1085a5ee354127f28895f3d8d4023f80670', 'They made a sort of encampment by the wayside, and the pony became
happy in the hedge. He told them of his own escape out of London, and
all that he knew of these Martians and their ways. The sun crept higher
in the sky, and after a time their talk died out and gave place to an
uneasy state of anticipation. Several wayfarers came along the lane,
and of these my brother gathered such news as he could. Every broken
answer he had deepened his impression of the great disaster that had
come on humanity, deepened his persuasion of the immediate necessity
for prosecuting this flight. He urged the matter upon them.', 544, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8c1c7976d2e4cb8f7235f278a36ff98dd22988f54d1ad6cd70e9cad6112e5998', '“We have money,” said the slender woman, and hesitated.', 545, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('588731d6453c22ba68c3656f0e102ebedfa1e1894cbab2f05cba2be77ec82ba3', 'Her eyes met my brother’s, and her hesitation ended.', 546, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('240fa55e3d524ac98604bfcfb296092aa4393a02c000f385d8c2c59b961e2138', '“So have I,” said my brother.', 547, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('87623091250d205ecde191cea1fc50bc38794d97911ec4d31d356c7380d233ef', 'She explained that they had as much as thirty pounds in gold, besides a
five-pound note, and suggested that with that they might get upon a
train at St. Albans or New Barnet. My brother thought that was
hopeless, seeing the fury of the Londoners to crowd upon the trains,
and broached his own idea of striking across Essex towards Harwich and
thence escaping from the country altogether.', 548, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f6c9647217681676c31b96273e384fdf2849207c0d78fbc896cc18daafdfa6ec', 'Mrs. Elphinstone—that was the name of the woman in white—would listen
to no reasoning, and kept calling upon “George”; but her sister-in-law
was astonishingly quiet and deliberate, and at last agreed to my
brother’s suggestion. So, designing to cross the Great North Road, they
went on towards Barnet, my brother leading the pony to save it as much
as possible. As the sun crept up the sky the day became excessively
hot, and under foot a thick, whitish sand grew burning and blinding, so
that they travelled only very slowly. The hedges were grey with dust.
And as they advanced towards Barnet a tumultuous murmuring grew
stronger.', 549, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bad2b3884f9f46185c81c556a59f6fafd894e52543e92c0276a353aca0283fe4', 'They began to meet more people. For the most part these were staring
before them, murmuring indistinct questions, jaded, haggard, unclean.
One man in evening dress passed them on foot, his eyes on the ground.
They heard his voice, and, looking back at him, saw one hand clutched
in his hair and the other beating invisible things. His paroxysm of
rage over, he went on his way without once looking back.', 550, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6b085edb1f8fc42b04a441f4985c2db9bcef6c89accfa0fbb3e0629d6f229a6c', 'As my brother’s party went on towards the crossroads to the south of
Barnet they saw a woman approaching the road across some fields on
their left, carrying a child and with two other children; and then
passed a man in dirty black, with a thick stick in one hand and a small
portmanteau in the other. Then round the corner of the lane, from
between the villas that guarded it at its confluence with the high
road, came a little cart drawn by a sweating black pony and driven by a
sallow youth in a bowler hat, grey with dust. There were three girls,
East End factory girls, and a couple of little children crowded in the
cart.', 551, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('218da250ce1c9074c07022a08898a6ad61856b60c62503389f03c22e164ead4c', '“This’ll tike us rahnd Edgware?” asked the driver, wild-eyed,
white-faced; and when my brother told him it would if he turned to the
left, he whipped up at once without the formality of thanks.', 552, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3338a64bcab5b7568148c3d02394427e20e2c04825e9d482c94a888611ae3e0e', 'My brother noticed a pale grey smoke or haze rising among the houses in
front of them, and veiling the white façade of a terrace beyond the
road that appeared between the backs of the villas. Mrs. Elphinstone
suddenly cried out at a number of tongues of smoky red flame leaping up
above the houses in front of them against the hot, blue sky. The
tumultuous noise resolved itself now into the disorderly mingling of
many voices, the gride of many wheels, the creaking of waggons, and the
staccato of hoofs. The lane came round sharply not fifty yards from the
crossroads.', 553, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4d5a5e89ba4a2daf8acf5d8d8d88227a11f681861fb5a624c7ab0855f97d5082', '“Good heavens!” cried Mrs. Elphinstone. “What is this you are driving
us into?”', 554, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eb231f998449125f91eec0c15b9c26becbf09a126b1ca73917304beaa1e1925a', 'My brother stopped.', 555, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7cc51eb900f48582301183a08210ea9a0ca78b5862bba6fb90d6e2c3bb022d74', 'For the main road was a boiling stream of people, a torrent of human
beings rushing northward, one pressing on another. A great bank of
dust, white and luminous in the blaze of the sun, made everything
within twenty feet of the ground grey and indistinct and was
perpetually renewed by the hurrying feet of a dense crowd of horses and
of men and women on foot, and by the wheels of vehicles of every
description.', 556, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('632a1b5987e197db2a4df2200c45b9cbaccd5fa70903ebb060dabb9d6f47bbcc', '“Way!” my brother heard voices crying. “Make way!”', 557, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a9632a1f1ea77ec73d14c7cd2d405abfd9acb3fb8b0a2472a6cb6c5ec4f82b2d', 'It was like riding into the smoke of a fire to approach the meeting
point of the lane and road; the crowd roared like a fire, and the dust
was hot and pungent. And, indeed, a little way up the road a villa was
burning and sending rolling masses of black smoke across the road to
add to the confusion.', 558, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('360b5a81d8c0ee29a041fa133fd6365e8fcdc6788364916a930abd1b04c68257', 'Two men came past them. Then a dirty woman, carrying a heavy bundle and
weeping. A lost retriever dog, with hanging tongue, circled dubiously
round them, scared and wretched, and fled at my brother’s threat.', 559, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('857bbd37f07617a5916ba7bccc0ff7cbab5c9741994edd100ee9275f77b4ced8', 'So much as they could see of the road Londonward between the houses to
the right was a tumultuous stream of dirty, hurrying people, pent in
between the villas on either side; the black heads, the crowded forms,
grew into distinctness as they rushed towards the corner, hurried past,
and merged their individuality again in a receding multitude that was
swallowed up at last in a cloud of dust.', 560, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e225c1278e734a23a1e9708ab64f645626ae8ef016cbf6ca3cc518c52816841a', '“Go on! Go on!” cried the voices. “Way! Way!”', 561, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('81933768b7b69a80a22e98b61aa728b8e1297ad4f388c8b1914c8a4b042031f5', 'One man’s hands pressed on the back of another. My brother stood at the
pony’s head. Irresistibly attracted, he advanced slowly, pace by pace,
down the lane.', 562, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('807679f5df74ff239581202366f352c7e0be81a0931cf9853260396b8f2fb8e9', 'Edgware had been a scene of confusion, Chalk Farm a riotous tumult, but
this was a whole population in movement. It is hard to imagine that
host. It had no character of its own. The figures poured out past the
corner, and receded with their backs to the group in the lane. Along
the margin came those who were on foot threatened by the wheels,
stumbling in the ditches, blundering into one another.', 563, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b8618568fe951fcf727c60f454e95d444786eef4dac057b17224df5a1e91c22a', 'The carts and carriages crowded close upon one another, making little
way for those swifter and more impatient vehicles that darted forward
every now and then when an opportunity showed itself of doing so,
sending the people scattering against the fences and gates of the
villas.', 564, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('38f571a36474add9b71558ea26f3cc4e284a7199b4bfe1988e5f477f4daf7908', '“Push on!” was the cry. “Push on! They are coming!”', 565, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0a2ca0b47d89a7326079ca1cab607b28ba3ee452fc89ba78dba97910dff5edca', 'In one cart stood a blind man in the uniform of the Salvation Army,
gesticulating with his crooked fingers and bawling, “Eternity!
Eternity!” His voice was hoarse and very loud so that my brother could
hear him long after he was lost to sight in the dust. Some of the
people who crowded in the carts whipped stupidly at their horses and
quarrelled with other drivers; some sat motionless, staring at nothing
with miserable eyes; some gnawed their hands with thirst, or lay
prostrate in the bottoms of their conveyances. The horses’ bits were
covered with foam, their eyes bloodshot.', 566, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('acb597e2dc1e986ce0b44f5967c0b9e78fca9a5c40de108058c19fa60b13753b', 'There were cabs, carriages, shop-carts, waggons, beyond counting; a
mail cart, a road-cleaner’s cart marked “Vestry of St. Pancras,” a huge
timber waggon crowded with roughs. A brewer’s dray rumbled by with its
two near wheels splashed with fresh blood.', 567, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('202a02baa647b0e7c09ce1bf759ada68653cedb4d130acf4b0d7ed5407c60902', '“Clear the way!” cried the voices. “Clear the way!”', 568, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('43530e5fe4942594819dbc79336f8f6819009a1482ecaafd15157a191eb3cfcb', '“Eter-nity! Eter-nity!” came echoing down the road.', 569, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6209eeec0b177146be5bde3e8d429c673ad5a75bd809a1b4f99ad621590c546e', 'There were sad, haggard women tramping by, well dressed, with children
that cried and stumbled, their dainty clothes smothered in dust, their
weary faces smeared with tears. With many of these came men, sometimes
helpful, sometimes lowering and savage. Fighting side by side with them
pushed some weary street outcast in faded black rags, wide-eyed,
loud-voiced, and foul-mouthed. There were sturdy workmen thrusting
their way along, wretched, unkempt men, clothed like clerks or shopmen,
struggling spasmodically; a wounded soldier my brother noticed, men
dressed in the clothes of railway porters, one wretched creature in a
nightshirt with a coat thrown over it.', 570, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('be2d8062ff2bf49c1efaf0e67385e7dd320e6d2e1c6a64cd368b427c149dd27f', 'But varied as its composition was, certain things all that host had in
common. There were fear and pain on their faces, and fear behind them.
A tumult up the road, a quarrel for a place in a waggon, sent the whole
host of them quickening their pace; even a man so scared and broken
that his knees bent under him was galvanised for a moment into renewed
activity. The heat and dust had already been at work upon this
multitude. Their skins were dry, their lips black and cracked. They
were all thirsty, weary, and footsore. And amid the various cries one
heard disputes, reproaches, groans of weariness and fatigue; the voices
of most of them were hoarse and weak. Through it all ran a refrain:', 571, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1187585ec72e32b2942af4e5f50c070e0ca7b7d06d9bddb4a49283380c03fb40', '“Way! Way! The Martians are coming!”', 572, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('14e7548ca45582aaa48f41f8aaa88f977d7f973c51e0bb3042d7703e3f2e154e', 'Few stopped and came aside from that flood. The lane opened slantingly
into the main road with a narrow opening, and had a delusive appearance
of coming from the direction of London. Yet a kind of eddy of people
drove into its mouth; weaklings elbowed out of the stream, who for the
most part rested but a moment before plunging into it again. A little
way down the lane, with two friends bending over him, lay a man with a
bare leg, wrapped about with bloody rags. He was a lucky man to have
friends.', 573, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('97c2967670ffe951949f0bc52bc93776ec31c8fbf03a776db39fc8f068b99465', 'A little old man, with a grey military moustache and a filthy black
frock coat, limped out and sat down beside the trap, removed his
boot—his sock was blood-stained—shook out a pebble, and hobbled on
again; and then a little girl of eight or nine, all alone, threw
herself under the hedge close by my brother, weeping.', 574, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('41ed6e67a1aa7266d1163d82b3bb29e1c9fd158a183a29ef93c7eedb3ef713bb', 'My brother woke from his torpor of astonishment and lifted her up,
speaking gently to her, and carried her to Miss Elphinstone. So soon as
my brother touched her she became quite still, as if frightened.', 576, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e409ba8062d7c250c6d97f80fa5f0a9b464f204dfc11a99e43c3807124e3ed7c', '“Ellen!” shrieked a woman in the crowd, with tears in her
voice—“Ellen!” And the child suddenly darted away from my brother,
crying “Mother!”', 577, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('18502f8ba6a45942a731ec1b3b2381dc9e9d9f7b70a95c09b131769f30a1cad9', '“They are coming,” said a man on horseback, riding past along the lane.', 578, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('40c0415dd20a96af61b35c59e5bd428e3b1b58fec8e5aab00607d6bc309e91f5', '“Out of the way, there!” bawled a coachman, towering high; and my
brother saw a closed carriage turning into the lane.', 579, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('65680b8a193141ac841e92d7e4cfca7e8885bdfd3950c6f7f7a4bcab375d5ee3', 'The people crushed back on one another to avoid the horse. My brother
pushed the pony and chaise back into the hedge, and the man drove by
and stopped at the turn of the way. It was a carriage, with a pole for
a pair of horses, but only one was in the traces. My brother saw dimly
through the dust that two men lifted out something on a white stretcher
and put it gently on the grass beneath the privet hedge.', 580, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('72a7f33eb30da285069ad1badaca7e433a4d5b78f2636bb2b025f5e64fab98b0', 'One of the men came running to my brother.', 581, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9fd0e30d554579e339b9fcca1efa90bb3408545f3f99f31f913558c228fb098e', '“Where is there any water?” he said. “He is dying fast, and very
thirsty. It is Lord Garrick.”', 582, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c3aee7f43530ef3cd1d73c1402a535d256815e1cf7d9ad4740f488640cc44cdc', '“Lord Garrick!” said my brother; “the Chief Justice?”', 583, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('437c74416e5e087c073c22599bb59b64bd75face1b98933485839e30335b4e00', '“The water?” he said.', 584, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e31a123df218769855f1597bbef7e099182bec6f13a97d4941a9edd6686e0bd8', '“There may be a tap,” said my brother, “in some of the houses. We have
no water. I dare not leave my people.”', 585, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('24a5b92b52427aea492eea148d227b245f9a61682e33b290393d1bd797c35424', 'The man pushed against the crowd towards the gate of the corner house.', 586, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ebd46cde36bfafdc97847ce0442370d7d22ee30d17e1880b1a97fb5dd7bb2deb', '“Go on!” said the people, thrusting at him. “They are coming! Go on!”', 587, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('604e3a93fce78d09a2b7b9d65c6e51c85561a4ac9c0359d6270e81c1538bf7ef', 'Then my brother’s attention was distracted by a bearded, eagle-faced
man lugging a small handbag, which split even as my brother’s eyes
rested on it and disgorged a mass of sovereigns that seemed to break up
into separate coins as it struck the ground. They rolled hither and
thither among the struggling feet of men and horses. The man stopped
and looked stupidly at the heap, and the shaft of a cab struck his
shoulder and sent him reeling. He gave a shriek and dodged back, and a
cartwheel shaved him narrowly.', 588, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8afbc8e1ee04aad42095c4dab75b8a7dc09452f8105d765f67650d92c78dd684', '“Way!” cried the men all about him. “Make way!”', 589, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2db10a749a0f2be5778616b6a3efdb04e4f2ac6cb669fe12443bdca6682d5f5f', 'So soon as the cab had passed, he flung himself, with both hands open,
upon the heap of coins, and began thrusting handfuls in his pocket. A
horse rose close upon him, and in another moment, half rising, he had
been borne down under the horse’s hoofs.', 590, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('acd545bd08089a1c3a8109043d42387cd60573a2f756568056e91ad698bc47d1', '“Stop!” screamed my brother, and pushing a woman out of his way, tried
to clutch the bit of the horse.', 591, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8a4f2be993f3f99c1829178c3b1dbd6d7550c60b8dd5c35c7cc7510f97276fe2', 'Before he could get to it, he heard a scream under the wheels, and saw
through the dust the rim passing over the poor wretch’s back. The
driver of the cart slashed his whip at my brother, who ran round behind
the cart. The multitudinous shouting confused his ears. The man was
writhing in the dust among his scattered money, unable to rise, for the
wheel had broken his back, and his lower limbs lay limp and dead. My
brother stood up and yelled at the next driver, and a man on a black
horse came to his assistance.', 592, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5e8e90eb1aab5372780011d37aa6e0530d1979f7b34356b2a5e02330e47eb7db', '“Get him out of the road,” said he; and, clutching the man’s collar
with his free hand, my brother lugged him sideways. But he still
clutched after his money, and regarded my brother fiercely, hammering
at his arm with a handful of gold. “Go on! Go on!” shouted angry voices
behind. “Way! Way!”', 593, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b236b30ce56e62d96de66c23f9954322a8e2f46351835ec959043f4ff3d35477', 'There was a smash as the pole of a carriage crashed into the cart that
the man on horseback stopped. My brother looked up, and the man with
the gold twisted his head round and bit the wrist that held his collar.
There was a concussion, and the black horse came staggering sideways,
and the carthorse pushed beside it. A hoof missed my brother’s foot by
a hair’s breadth. He released his grip on the fallen man and jumped
back. He saw anger change to terror on the face of the poor wretch on
the ground, and in a moment he was hidden and my brother was borne
backward and carried past the entrance of the lane, and had to fight
hard in the torrent to recover it.', 594, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c5e924c48ed5df4f50203463a08359daff7f2af9b7a355bceb80891fb9cd86a6', 'He saw Miss Elphinstone covering her eyes, and a little child, with all
a child’s want of sympathetic imagination, staring with dilated eyes at
a dusty something that lay black and still, ground and crushed under
the rolling wheels. “Let us go back!” he shouted, and began turning the
pony round. “We cannot cross this—hell,” he said and they went back a
hundred yards the way they had come, until the fighting crowd was
hidden. As they passed the bend in the lane my brother saw the face of
the dying man in the ditch under the privet, deadly white and drawn,
and shining with perspiration. The two women sat silent, crouching in
their seat and shivering.', 595, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('238bfba73597be83f05b1d3f8ef78131fe0fcd501fd2a911f47c6368eb646c04', 'Then beyond the bend my brother stopped again. Miss Elphinstone was
white and pale, and her sister-in-law sat weeping, too wretched even to
call upon “George.” My brother was horrified and perplexed. So soon as
they had retreated he realised how urgent and unavoidable it was to
attempt this crossing. He turned to Miss Elphinstone, suddenly
resolute.', 596, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8122419e33990338c143c0dfb8528ba913d90875145fde331d4b9297faaba8f5', '“We must go that way,” he said, and led the pony round again.', 597, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1f15bed9c18181d6b687b178125588a2a0bb3f2dabb549cf9f8e5c7583e15915', 'For the second time that day this girl proved her quality. To force
their way into the torrent of people, my brother plunged into the
traffic and held back a cab horse, while she drove the pony across its
head. A waggon locked wheels for a moment and ripped a long splinter
from the chaise. In another moment they were caught and swept forward
by the stream. My brother, with the cabman’s whip marks red across his
face and hands, scrambled into the chaise and took the reins from her.', 598, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0fe62337296ed0d777a95b45054893e05750703ab05d29d7260c1f12b2c74727', '“Point the revolver at the man behind,” he said, giving it to her, “if
he presses us too hard. No!—point it at his horse.”', 599, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ee91f101558f51bebdc48e67beb4427a1660a911256abcd5685f00906f027c2f', 'Then he began to look out for a chance of edging to the right across
the road. But once in the stream he seemed to lose volition, to become
a part of that dusty rout. They swept through Chipping Barnet with the
torrent; they were nearly a mile beyond the centre of the town before
they had fought across to the opposite side of the way. It was din and
confusion indescribable; but in and beyond the town the road forks
repeatedly, and this to some extent relieved the stress.', 600, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dcfa14ed93fb26d0f704c24786a782583511c6bfc36ba8b45d74e4bd2038d226', 'They struck eastward through Hadley, and there on either side of the
road, and at another place farther on they came upon a great multitude
of people drinking at the stream, some fighting to come at the water.
And farther on, from a lull near East Barnet, they saw two trains
running slowly one after the other without signal or order—trains
swarming with people, with men even among the coals behind the
engines—going northward along the Great Northern Railway. My brother
supposes they must have filled outside London, for at that time the
furious terror of the people had rendered the central termini
impossible.', 601, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c734833eac65949c869e4dc98eba960e5c3ee1919259ed2bb2cd6aa7a4c0d630', 'Near this place they halted for the rest of the afternoon, for the
violence of the day had already utterly exhausted all three of them.
They began to suffer the beginnings of hunger; the night was cold, and
none of them dared to sleep. And in the evening many people came
hurrying along the road nearby their stopping place, fleeing from
unknown dangers before them, and going in the direction from which my
brother had come.', 602, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4cccfdbf3efafa69699753d7eb75a12b4a9b42dff25129c45193f652eaa4800d', '', 603, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('34aa813ac3ab509e0e95922c006456914f8969db2fdaec1f09774c06de741808', '
XVII.
THE “THUNDER CHILD”.', 604, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('394755d3283bf39a08206ca1f4315206bc73793f067c4c416db8c001af81f657', '
Had the Martians aimed only at destruction, they might on Monday have
annihilated the entire population of London, as it spread itself slowly
through the home counties. Not only along the road through Barnet, but
also through Edgware and Waltham Abbey, and along the roads eastward to
Southend and Shoeburyness, and south of the Thames to Deal and
Broadstairs, poured the same frantic rout. If one could have hung that
June morning in a balloon in the blazing blue above London every
northward and eastward road running out of the tangled maze of streets
would have seemed stippled black with the streaming fugitives, each dot
a human agony of terror and physical distress. I have set forth at
length in the last chapter my brother’s account of the road through
Chipping Barnet, in order that my readers may realise how that swarming
of black dots appeared to one of those concerned. Never before in the
history of the world had such a mass of human beings moved and suffered
together. The legendary hosts of Goths and Huns, the hugest armies Asia
has ever seen, would have been but a drop in that current. And this was
no disciplined march; it was a stampede—a stampede gigantic and
terrible—without order and without a goal, six million people unarmed
and unprovisioned, driving headlong. It was the beginning of the rout
of civilisation, of the massacre of mankind.', 605, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('499d24c28baa1317e6d7ac542830bf203ffddd10b8dbc6943f74bb6b1495407e', 'Directly below him the balloonist would have seen the network of
streets far and wide, houses, churches, squares, crescents,
gardens—already derelict—spread out like a huge map, and in the
southward _blotted_. Over Ealing, Richmond, Wimbledon, it would have
seemed as if some monstrous pen had flung ink upon the chart. Steadily,
incessantly, each black splash grew and spread, shooting out
ramifications this way and that, now banking itself against rising
ground, now pouring swiftly over a crest into a new-found valley,
exactly as a gout of ink would spread itself upon blotting paper.', 606, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7f381c2c151f7f0e08dbd74edb9db1dbfd075796c4280bd960d2c455bdd398b7', 'And beyond, over the blue hills that rise southward of the river, the
glittering Martians went to and fro, calmly and methodically spreading
their poison cloud over this patch of country and then over that,
laying it again with their steam jets when it had served its purpose,
and taking possession of the conquered country. They do not seem to
have aimed at extermination so much as at complete demoralisation and
the destruction of any opposition. They exploded any stores of powder
they came upon, cut every telegraph, and wrecked the railways here and
there. They were hamstringing mankind. They seemed in no hurry to
extend the field of their operations, and did not come beyond the
central part of London all that day. It is possible that a very
considerable number of people in London stuck to their houses through
Monday morning. Certain it is that many died at home suffocated by the
Black Smoke.', 607, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('093756f95bee9b7acf682767a33c27deab1c05a77d6312bccdb182a803b4c85b', 'It was with the greatest difficulty they could get her down to the
beach, where presently my brother succeeded in attracting the attention
of some men on a paddle steamer from the Thames. They sent a boat and
drove a bargain for thirty-six pounds for the three. The steamer was
going, these men said, to Ostend.', 618, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3468d7844064acc96b787192604d56bf19d684e65db0be73f9517423633781a6', 'Until about midday the Pool of London was an astonishing scene.
Steamboats and shipping of all sorts lay there, tempted by the enormous
sums of money offered by fugitives, and it is said that many who swam
out to these vessels were thrust off with boathooks and drowned. About
one o’clock in the afternoon the thinning remnant of a cloud of the
black vapour appeared between the arches of Blackfriars Bridge. At that
the Pool became a scene of mad confusion, fighting, and collision, and
for some time a multitude of boats and barges jammed in the northern
arch of the Tower Bridge, and the sailors and lightermen had to fight
savagely against the people who swarmed upon them from the riverfront.
People were actually clambering down the piers of the bridge from
above.', 608, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('39aa08197559be1b7acc0c8a69460fae7cdf5ced15c8c98d4cb6289635e9ff1f', 'When, an hour later, a Martian appeared beyond the Clock Tower and
waded down the river, nothing but wreckage floated above Limehouse.', 609, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dbbab8bfa033b668a666a2b17fe0ffe6f142686abc07a8ba3961c55accc23ca1', 'Of the falling of the fifth cylinder I have presently to tell. The
sixth star fell at Wimbledon. My brother, keeping watch beside the
women in the chaise in a meadow, saw the green flash of it far beyond
the hills. On Tuesday the little party, still set upon getting across
the sea, made its way through the swarming country towards Colchester.
The news that the Martians were now in possession of the whole of
London was confirmed. They had been seen at Highgate, and even, it was
said, at Neasden. But they did not come into my brother’s view until
the morrow.', 610, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('748f9429e93312f095eed0a9630fc68c77f6aa7a7f385b23759aa7c7d9c398c9', 'That day the scattered multitudes began to realise the urgent need of
provisions. As they grew hungry the rights of property ceased to be
regarded. Farmers were out to defend their cattle-sheds, granaries, and
ripening root crops with arms in their hands. A number of people now,
like my brother, had their faces eastward, and there were some
desperate souls even going back towards London to get food. These were
chiefly people from the northern suburbs, whose knowledge of the Black
Smoke came by hearsay. He heard that about half the members of the
government had gathered at Birmingham, and that enormous quantities of
high explosives were being prepared to be used in automatic mines
across the Midland counties.', 611, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0b4cee435bda02fc13179a679dbc823accff332434f294fd1b271c8d287d523a', 'He was also told that the Midland Railway Company had replaced the
desertions of the first day’s panic, had resumed traffic, and was
running northward trains from St. Albans to relieve the congestion of
the home counties. There was also a placard in Chipping Ongar
announcing that large stores of flour were available in the northern
towns and that within twenty-four hours bread would be distributed
among the starving people in the neighbourhood. But this intelligence
did not deter him from the plan of escape he had formed, and the three
pressed eastward all day, and heard no more of the bread distribution
than this promise. Nor, as a matter of fact, did anyone else hear more
of it. That night fell the seventh star, falling upon Primrose Hill. It
fell while Miss Elphinstone was watching, for she took that duty
alternately with my brother. She saw it.', 612, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('341a1a89891f47f4cf569b70ff4251cf380745e1524663f4c770170cfc7cd91f', 'On Wednesday the three fugitives—they had passed the night in a field
of unripe wheat—reached Chelmsford, and there a body of the
inhabitants, calling itself the Committee of Public Supply, seized the
pony as provisions, and would give nothing in exchange for it but the
promise of a share in it the next day. Here there were rumours of
Martians at Epping, and news of the destruction of Waltham Abbey Powder
Mills in a vain attempt to blow up one of the invaders.', 613, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ba347eae49479203d82bcf6c33e56c6a8e1afea5121e8d4f2bd27df931026cda', 'People were watching for Martians here from the church towers. My
brother, very luckily for him as it chanced, preferred to push on at
once to the coast rather than wait for food, although all three of them
were very hungry. By midday they passed through Tillingham, which,
strangely enough, seemed to be quite silent and deserted, save for a
few furtive plunderers hunting for food. Near Tillingham they suddenly
came in sight of the sea, and the most amazing crowd of shipping of all
sorts that it is possible to imagine.', 614, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f949773fc2b6c03a8220d783cb851dafa18417e373c1e59fb711278f2cf65251', 'For after the sailors could no longer come up the Thames, they came on
to the Essex coast, to Harwich and Walton and Clacton, and afterwards
to Foulness and Shoebury, to bring off the people. They lay in a huge
sickle-shaped curve that vanished into mist at last towards the Naze.
Close inshore was a multitude of fishing smacks—English, Scotch,
French, Dutch, and Swedish; steam launches from the Thames, yachts,
electric boats; and beyond were ships of larger burden, a multitude of
filthy colliers, trim merchantmen, cattle ships, passenger boats,
petroleum tanks, ocean tramps, an old white transport even, neat white
and grey liners from Southampton and Hamburg; and along the blue coast
across the Blackwater my brother could make out dimly a dense swarm of
boats chaffering with the people on the beach, a swarm which also
extended up the Blackwater almost to Maldon.', 615, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('52bf4fd24b0cfea358700bedd07cad080223f7175cae657dcbb26ed5b909a7e2', 'About a couple of miles out lay an ironclad, very low in the water,
almost, to my brother’s perception, like a water-logged ship. This was
the ram _Thunder Child_. It was the only warship in sight, but far away
to the right over the smooth surface of the sea—for that day there was
a dead calm—lay a serpent of black smoke to mark the next ironclads of
the Channel Fleet, which hovered in an extended line, steam up and
ready for action, across the Thames estuary during the course of the
Martian conquest, vigilant and yet powerless to prevent it.', 616, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b13aab5721984fa207bece3831ce338fa989a016434371e5260caaaedd672ba8', 'At the sight of the sea, Mrs. Elphinstone, in spite of the assurances
of her sister-in-law, gave way to panic. She had never been out of
England before, she would rather die than trust herself friendless in a
foreign country, and so forth. She seemed, poor woman, to imagine that
the French and the Martians might prove very similar. She had been
growing increasingly hysterical, fearful, and depressed during the two
days’ journeyings. Her great idea was to return to Stanmore. Things had
been always well and safe at Stanmore. They would find George at
Stanmore....', 617, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ded7c209ba738b5d331a0ade2a04cd122d572802ce3234efef76537c4c6cbc15', '“I come from Mortlake,” I said. “I was buried near the pit the Martians
made about their cylinder. I have worked my way out and escaped.”', 804, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('637fd1d004378b4cf5a94cd5ee1a445eb575a657ec647d9893051412d083e1e7', 'It was about two o’clock when my brother, having paid their fares at
the gangway, found himself safely aboard the steamboat with his
charges. There was food aboard, albeit at exorbitant prices, and the
three of them contrived to eat a meal on one of the seats forward.', 619, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('45b5328ef4b5e52e5f5a0687e16ddcf36175150ecfa272a49bb06be45444dce3', 'There were already a couple of score of passengers aboard, some of whom
had expended their last money in securing a passage, but the captain
lay off the Blackwater until five in the afternoon, picking up
passengers until the seated decks were even dangerously crowded. He
would probably have remained longer had it not been for the sound of
guns that began about that hour in the south. As if in answer, the
ironclad seaward fired a small gun and hoisted a string of flags. A jet
of smoke sprang out of her funnels.', 620, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f2420358731e84656d5a7afaefd68fafb63375a8bbf4b2352b80a9435c12210f', 'Some of the passengers were of opinion that this firing came from
Shoeburyness, until it was noticed that it was growing louder. At the
same time, far away in the southeast the masts and upperworks of three
ironclads rose one after the other out of the sea, beneath clouds of
black smoke. But my brother’s attention speedily reverted to the
distant firing in the south. He fancied he saw a column of smoke rising
out of the distant grey haze.', 621, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6edea582ae6e4db3dc09a86f60ed3dd144192e154162e21600607dda3ce9b276', 'The little steamer was already flapping her way eastward of the big
crescent of shipping, and the low Essex coast was growing blue and
hazy, when a Martian appeared, small and faint in the remote distance,
advancing along the muddy coast from the direction of Foulness. At that
the captain on the bridge swore at the top of his voice with fear and
anger at his own delay, and the paddles seemed infected with his
terror. Every soul aboard stood at the bulwarks or on the seats of the
steamer and stared at that distant shape, higher than the trees or
church towers inland, and advancing with a leisurely parody of a human
stride.', 622, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('22945c5d4defdcdfc29a067be2387d77ddb485514bcf19990ad9a9f79a7a9327', 'It was the first Martian my brother had seen, and he stood, more amazed
than terrified, watching this Titan advancing deliberately towards the
shipping, wading farther and farther into the water as the coast fell
away. Then, far away beyond the Crouch, came another, striding over
some stunted trees, and then yet another, still farther off, wading
deeply through a shiny mudflat that seemed to hang halfway up between
sea and sky. They were all stalking seaward, as if to intercept the
escape of the multitudinous vessels that were crowded between Foulness
and the Naze. In spite of the throbbing exertions of the engines of the
little paddle-boat, and the pouring foam that her wheels flung behind
her, she receded with terrifying slowness from this ominous advance.', 623, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8ff7bd58b48492873c1e1e2903a24a83d5c93945b033f018c599d2f13a3693a0', 'Glancing northwestward, my brother saw the large crescent of shipping
already writhing with the approaching terror; one ship passing behind
another, another coming round from broadside to end on, steamships
whistling and giving off volumes of steam, sails being let out,
launches rushing hither and thither. He was so fascinated by this and
by the creeping danger away to the left that he had no eyes for
anything seaward. And then a swift movement of the steamboat (she had
suddenly come round to avoid being run down) flung him headlong from
the seat upon which he was standing. There was a shouting all about
him, a trampling of feet, and a cheer that seemed to be answered
faintly. The steamboat lurched and rolled him over upon his hands.', 624, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('151f4a896b18f5169c720778161dcfda346175fdb599957fe0bf838e36613147', 'He sprang to his feet and saw to starboard, and not a hundred yards
from their heeling, pitching boat, a vast iron bulk like the blade of a
plough tearing through the water, tossing it on either side in huge
waves of foam that leaped towards the steamer, flinging her paddles
helplessly in the air, and then sucking her deck down almost to the
waterline.', 625, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6ff1abc88b36bcd9ab1b5157039cf8669e0298fe2b9a6eeeeed8e69f1bf3fb6c', 'A douche of spray blinded my brother for a moment. When his eyes were
clear again he saw the monster had passed and was rushing landward. Big
iron upperworks rose out of this headlong structure, and from that twin
funnels projected and spat a smoking blast shot with fire. It was the
torpedo ram, _Thunder Child_, steaming headlong, coming to the rescue
of the threatened shipping.', 626, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5d234da7aa65d5df86445d65095be7e9fcfd2ff0d4f6c118c51d57dd414f9d34', 'Keeping his footing on the heaving deck by clutching the bulwarks, my
brother looked past this charging leviathan at the Martians again, and
he saw the three of them now close together, and standing so far out to
sea that their tripod supports were almost entirely submerged. Thus
sunken, and seen in remote perspective, they appeared far less
formidable than the huge iron bulk in whose wake the steamer was
pitching so helplessly. It would seem they were regarding this new
antagonist with astonishment. To their intelligence, it may be, the
giant was even such another as themselves. The _Thunder Child_ fired no
gun, but simply drove full speed towards them. It was probably her not
firing that enabled her to get so near the enemy as she did. They did
not know what to make of her. One shell, and they would have sent her
to the bottom forthwith with the Heat-Ray.', 627, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('57307ba63d129981781754ef4aba360cf88066097facef150365385c3ab052c6', 'She was steaming at such a pace that in a minute she seemed halfway
between the steamboat and the Martians—a diminishing black bulk against
the receding horizontal expanse of the Essex coast.', 628, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('83a481f3fafbbf864dc2bd326828e893e10393a5f58400a91e2e8d23015d8ef1', 'Suddenly the foremost Martian lowered his tube and discharged a
canister of the black gas at the ironclad. It hit her larboard side and
glanced off in an inky jet that rolled away to seaward, an unfolding
torrent of Black Smoke, from which the ironclad drove clear. To the
watchers from the steamer, low in the water and with the sun in their
eyes, it seemed as though she were already among the Martians.', 629, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('77daa5038a54954112161f28ce37980e6b67d0e7ab8d4bf0da8e1196bac1f346', 'They saw the gaunt figures separating and rising out of the water as
they retreated shoreward, and one of them raised the camera-like
generator of the Heat-Ray. He held it pointing obliquely downward, and
a bank of steam sprang from the water at its touch. It must have driven
through the iron of the ship’s side like a white-hot iron rod through
paper.', 630, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bdd1187bc35bec69956eb58e229f3f0d4535dcc7bd77577d45985a7c6c17e5f5', 'A flicker of flame went up through the rising steam, and then the
Martian reeled and staggered. In another moment he was cut down, and a
great body of water and steam shot high in the air. The guns of the
_Thunder Child_ sounded through the reek, going off one after the
other, and one shot splashed the water high close by the steamer,
ricocheted towards the other flying ships to the north, and smashed a
smack to matchwood.', 631, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fd60f0b01a526ad0866ade755a17ad000504f832a1ec096003653b25f560bb5a', 'But no one heeded that very much. At the sight of the Martian’s
collapse the captain on the bridge yelled inarticulately, and all the
crowding passengers on the steamer’s stern shouted together. And then
they yelled again. For, surging out beyond the white tumult, drove
something long and black, the flames streaming from its middle parts,
its ventilators and funnels spouting fire.', 632, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e2b4baf97e733c63943d7a006235c152b3fb1d4c8e3f2463093b540784c6f1de', 'She was alive still; the steering gear, it seems, was intact and her
engines working. She headed straight for a second Martian, and was
within a hundred yards of him when the Heat-Ray came to bear. Then with
a violent thud, a blinding flash, her decks, her funnels, leaped
upward. The Martian staggered with the violence of her explosion, and
in another moment the flaming wreckage, still driving forward with the
impetus of its pace, had struck him and crumpled him up like a thing of
cardboard. My brother shouted involuntarily. A boiling tumult of steam
hid everything again.', 633, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d620cca53f96963ab55bde0809f484a5f80ad0faac7db9e5c82160efa7920f95', '“Two!” yelled the captain.', 634, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('45a2364866739a4c536a2c5bcd6517f0c34baafcf0adc64468b3b4cada6ad2e5', 'Everyone was shouting. The whole steamer from end to end rang with
frantic cheering that was taken up first by one and then by all in the
crowding multitude of ships and boats that was driving out to sea.', 635, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0648d3bccda8c2a0c1429f860ea071f1e279cc05234e36d6ed57f12bd6806265', 'The steam hung upon the water for many minutes, hiding the third
Martian and the coast altogether. And all this time the boat was
paddling steadily out to sea and away from the fight; and when at last
the confusion cleared, the drifting bank of black vapour intervened,
and nothing of the _Thunder Child_ could be made out, nor could the
third Martian be seen. But the ironclads to seaward were now quite
close and standing in towards shore past the steamboat.', 636, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('24e3002cbc7ba6f94ea06a4d358afac6b29bf93e361cad8dec0bdc17ca9c413b', 'The little vessel continued to beat its way seaward, and the ironclads
receded slowly towards the coast, which was hidden still by a marbled
bank of vapour, part steam, part black gas, eddying and combining in
the strangest way. The fleet of refugees was scattering to the
northeast; several smacks were sailing between the ironclads and the
steamboat. After a time, and before they reached the sinking cloud
bank, the warships turned northward, and then abruptly went about and
passed into the thickening haze of evening southward. The coast grew
faint, and at last indistinguishable amid the low banks of clouds that
were gathering about the sinking sun.', 637, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8690241cbfea844d2b7fc8a7a55999ee5cf96bb61ef644f41bf380574ec59626', 'Then suddenly out of the golden haze of the sunset came the vibration
of guns, and a form of black shadows moving. Everyone struggled to the
rail of the steamer and peered into the blinding furnace of the west,
but nothing was to be distinguished clearly. A mass of smoke rose
slanting and barred the face of the sun. The steamboat throbbed on its
way through an interminable suspense.', 638, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8df2f365997764d2bc87e887131ebd35203b3b7f9e6cc5130031b2d09ed127aa', 'The sun sank into grey clouds, the sky flushed and darkened, the
evening star trembled into sight. It was deep twilight when the captain
cried out and pointed. My brother strained his eyes. Something rushed
up into the sky out of the greyness—rushed slantingly upward and very
swiftly into the luminous clearness above the clouds in the western
sky; something flat and broad, and very large, that swept round in a
vast curve, grew smaller, sank slowly, and vanished again into the grey
mystery of the night. And as it flew it rained down darkness upon the
land.', 639, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('25b90b182105624b9e733112af21b0be4beeef46ab306f2f9b7a61c48d04145a', '', 640, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9dde13d8fbd00f5516437789ea0026c995f382a6094d2f241ab43bc3ba3155bc', '
BOOK TWO
THE EARTH UNDER THE MARTIANS.', 641, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('46e7ea2226c635fd2624610d3b156158e39215873313fd588ec1743b2874e0e1', '', 642, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5495f8cf245b992e6c5b4c4e82731e6bd2dcce51e46c650e6f98f9127ec7425a', '
I.
UNDER FOOT.', 643, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dee721886121ab3210841650d7b6d87b9bf8e08287642a2e1cd3423794f45f4c', '
In the first book I have wandered so much from my own adventures to
tell of the experiences of my brother that all through the last two
chapters I and the curate have been lurking in the empty house at
Halliford whither we fled to escape the Black Smoke. There I will
resume. We stopped there all Sunday night and all the next day—the day
of the panic—in a little island of daylight, cut off by the Black Smoke
from the rest of the world. We could do nothing but wait in aching
inactivity during those two weary days.', 644, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b91574d8e1a57d02890f1810075f18515ab4c33175751fa796f2be831fb55ddf', 'My mind was occupied by anxiety for my wife. I figured her at
Leatherhead, terrified, in danger, mourning me already as a dead man. I
paced the rooms and cried aloud when I thought of how I was cut off
from her, of all that might happen to her in my absence. My cousin I
knew was brave enough for any emergency, but he was not the sort of man
to realise danger quickly, to rise promptly. What was needed now was
not bravery, but circumspection. My only consolation was to believe
that the Martians were moving Londonward and away from her. Such vague
anxieties keep the mind sensitive and painful. I grew very weary and
irritable with the curate’s perpetual ejaculations; I tired of the
sight of his selfish despair. After some ineffectual remonstrance I
kept away from him, staying in a room—evidently a children’s
schoolroom—containing globes, forms, and copybooks. When he followed me
thither, I went to a box room at the top of the house and, in order to
be alone with my aching miseries, locked myself in.', 645, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0ee8c848d479995cb1e46edf15f618326080889a6719313a72dd0912ceac68d0', '“It is you,” said he; “the man from Woking. And you weren’t killed at
Weybridge?”', 811, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('74fc05d705184f33c0d7a4726270176ef370b0972b70f489665cff281a72ef7e', 'We were hopelessly hemmed in by the Black Smoke all that day and the
morning of the next. There were signs of people in the next house on
Sunday evening—a face at a window and moving lights, and later the
slamming of a door. But I do not know who these people were, nor what
became of them. We saw nothing of them next day. The Black Smoke
drifted slowly riverward all through Monday morning, creeping nearer
and nearer to us, driving at last along the roadway outside the house
that hid us.', 646, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bc5d191129c10f0a245b9ac4bf0432c41e19941d1f81520894f810fb7dd1e47e', 'A Martian came across the fields about midday, laying the stuff with a
jet of superheated steam that hissed against the walls, smashed all the
windows it touched, and scalded the curate’s hand as he fled out of the
front room. When at last we crept across the sodden rooms and looked
out again, the country northward was as though a black snowstorm had
passed over it. Looking towards the river, we were astonished to see an
unaccountable redness mingling with the black of the scorched meadows.', 647, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e99df6cbc1e1cc4f245082379ecb16626437e4a69787b5a9018b53708dd62817', 'For a time we did not see how this change affected our position, save
that we were relieved of our fear of the Black Smoke. But later I
perceived that we were no longer hemmed in, that now we might get away.
So soon as I realised that the way of escape was open, my dream of
action returned. But the curate was lethargic, unreasonable.', 648, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4a248079eaeda097af6685c0b0b9319505b1fee396a431caac88e777994c826c', '“We are safe here,” he repeated; “safe here.”', 649, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f254b5bf9bf41f8e743778a0d116ff9604e947212f783cce29b18a15f070d379', 'I resolved to leave him—would that I had! Wiser now for the
artilleryman’s teaching, I sought out food and drink. I had found oil
and rags for my burns, and I also took a hat and a flannel shirt that I
found in one of the bedrooms. When it was clear to him that I meant to
go alone—had reconciled myself to going alone—he suddenly roused
himself to come. And all being quiet throughout the afternoon, we
started about five o’clock, as I should judge, along the blackened road
to Sunbury.', 650, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7f69b9d3488c6fba6c39efc809db738633f12b720b1380d63915f5c57de1d864', 'In Sunbury, and at intervals along the road, were dead bodies lying in
contorted attitudes, horses as well as men, overturned carts and
luggage, all covered thickly with black dust. That pall of cindery
powder made me think of what I had read of the destruction of Pompeii.
We got to Hampton Court without misadventure, our minds full of strange
and unfamiliar appearances, and at Hampton Court our eyes were relieved
to find a patch of green that had escaped the suffocating drift. We
went through Bushey Park, with its deer going to and fro under the
chestnuts, and some men and women hurrying in the distance towards
Hampton, and so we came to Twickenham. These were the first people we
saw.', 651, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0d3766a665cc13307e9df72fed168321171a172c6a83514e45c0cc78cb1d59b3', 'Away across the road the woods beyond Ham and Petersham were still
afire. Twickenham was uninjured by either Heat-Ray or Black Smoke, and
there were more people about here, though none could give us news. For
the most part they were like ourselves, taking advantage of a lull to
shift their quarters. I have an impression that many of the houses here
were still occupied by scared inhabitants, too frightened even for
flight. Here too the evidence of a hasty rout was abundant along the
road. I remember most vividly three smashed bicycles in a heap, pounded
into the road by the wheels of subsequent carts. We crossed Richmond
Bridge about half past eight. We hurried across the exposed bridge, of
course, but I noticed floating down the stream a number of red masses,
some many feet across. I did not know what these were—there was no time
for scrutiny—and I put a more horrible interpretation on them than they
deserved. Here again on the Surrey side were black dust that had once
been smoke, and dead bodies—a heap near the approach to the station;
but we had no glimpse of the Martians until we were some way towards
Barnes.', 652, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e09d6f9935e9ae1d226e48482d216a5c4ee1044c9e8e0c3c17fe6412d4622e79', 'We saw in the blackened distance a group of three people running down a
side street towards the river, but otherwise it seemed deserted. Up the
hill Richmond town was burning briskly; outside the town of Richmond
there was no trace of the Black Smoke.', 653, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1c2c22a499fa2f46d77370c0f66c5a83434041a86b494cbec469c13c26461075', 'Then suddenly, as we approached Kew, came a number of people running,
and the upperworks of a Martian fighting-machine loomed in sight over
the housetops, not a hundred yards away from us. We stood aghast at our
danger, and had the Martian looked down we must immediately have
perished. We were so terrified that we dared not go on, but turned
aside and hid in a shed in a garden. There the curate crouched, weeping
silently, and refusing to stir again.', 654, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a913f55cc9d24edf5f4a2d46e4a0ae1d5ff996c8d700cd666632ca6518f39b47', 'But my fixed idea of reaching Leatherhead would not let me rest, and in
the twilight I ventured out again. I went through a shrubbery, and
along a passage beside a big house standing in its own grounds, and so
emerged upon the road towards Kew. The curate I left in the shed, but
he came hurrying after me.', 655, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5ca884615d373612ae448c70b7aa2c0379591c5923ffc4be2923236571446418', 'That second start was the most foolhardy thing I ever did. For it was
manifest the Martians were about us. No sooner had the curate overtaken
me than we saw either the fighting-machine we had seen before or
another, far away across the meadows in the direction of Kew Lodge.
Four or five little black figures hurried before it across the
green-grey of the field, and in a moment it was evident this Martian
pursued them. In three strides he was among them, and they ran
radiating from his feet in all directions. He used no Heat-Ray to
destroy them, but picked them up one by one. Apparently he tossed them
into the great metallic carrier which projected behind him, much as a
workman’s basket hangs over his shoulder.', 656, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b445420cb35c84791bf7a388e95a4cad44dd6a97caf1a5e8f0ef19a89a4120a6', 'It was the first time I realised that the Martians might have any other
purpose than destruction with defeated humanity. We stood for a moment
petrified, then turned and fled through a gate behind us into a walled
garden, fell into, rather than found, a fortunate ditch, and lay there,
scarce daring to whisper to each other until the stars were out.', 657, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1fc89ab08105cbcfb8d429f3dbcceaf795277da92b7ceb2466ecba7a70d255b3', 'I recognised him at the same moment.', 812, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c94cbdf2b3f935dea37d74805b45ebf9033f4dae9481b02d5a8696990e96111a', 'I suppose it was nearly eleven o’clock before we gathered courage to
start again, no longer venturing into the road, but sneaking along
hedgerows and through plantations, and watching keenly through the
darkness, he on the right and I on the left, for the Martians, who
seemed to be all about us. In one place we blundered upon a scorched
and blackened area, now cooling and ashen, and a number of scattered
dead bodies of men, burned horribly about the heads and trunks but with
their legs and boots mostly intact; and of dead horses, fifty feet,
perhaps, behind a line of four ripped guns and smashed gun carriages.', 658, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e5fe4a5d6abcacb4a21a93aecff6ee23985f653a11f68e4a21a9fc729f7a1d91', 'Sheen, it seemed, had escaped destruction, but the place was silent and
deserted. Here we happened on no dead, though the night was too dark
for us to see into the side roads of the place. In Sheen my companion
suddenly complained of faintness and thirst, and we decided to try one
of the houses.', 659, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('450288542a3331d94903f2307441be82adc1a34adf0bfcedf73c690d2d9d7997', 'The first house we entered, after a little difficulty with the window,
was a small semi-detached villa, and I found nothing eatable left in
the place but some mouldy cheese. There was, however, water to drink;
and I took a hatchet, which promised to be useful in our next
house-breaking.', 660, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('18aba86821a608aec5efd34f7ee46cf991c139784a62c0555afb308498049367', 'We then crossed to a place where the road turns towards Mortlake. Here
there stood a white house within a walled garden, and in the pantry of
this domicile we found a store of food—two loaves of bread in a pan, an
uncooked steak, and the half of a ham. I give this catalogue so
precisely because, as it happened, we were destined to subsist upon
this store for the next fortnight. Bottled beer stood under a shelf,
and there were two bags of haricot beans and some limp lettuces. This
pantry opened into a kind of wash-up kitchen, and in this was firewood;
there was also a cupboard, in which we found nearly a dozen of
burgundy, tinned soups and salmon, and two tins of biscuits.', 661, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('61b26d71c6caf1b13783963f71515a76c9545599b3e17f68c5e484e066ce9cb9', 'We sat in the adjacent kitchen in the dark—for we dared not strike a
light—and ate bread and ham, and drank beer out of the same bottle. The
curate, who was still timorous and restless, was now, oddly enough, for
pushing on, and I was urging him to keep up his strength by eating when
the thing happened that was to imprison us.', 662, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('de9eac4f33af7c70784370c32c4b02b0f28817a7a2ffba047e5b89dcadb5db9e', '“It can’t be midnight yet,” I said, and then came a blinding glare of
vivid green light. Everything in the kitchen leaped out, clearly
visible in green and black, and vanished again. And then followed such
a concussion as I have never heard before or since. So close on the
heels of this as to seem instantaneous came a thud behind me, a clash
of glass, a crash and rattle of falling masonry all about us, and the
plaster of the ceiling came down upon us, smashing into a multitude of
fragments upon our heads. I was knocked headlong across the floor
against the oven handle and stunned. I was insensible for a long time,
the curate told me, and when I came to we were in darkness again, and
he, with a face wet, as I found afterwards, with blood from a cut
forehead, was dabbing water over me.', 663, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0df79fcaa7109b395bd3b4936554f67f35431ae5c610ff6e9bc5ed9d9b46aa11', 'For some time I could not recollect what had happened. Then things came
to me slowly. A bruise on my temple asserted itself.', 664, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0cf9b0a4b7800ff37b4728b82fd0803c34fd0cdd4dca0e491c53574ae1758c2d', '“Are you better?” asked the curate in a whisper.', 665, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('17a5b613c4530881f0034e33bdd705302464ef48b21ff7fd63b170f98a3762d1', 'At last I answered him. I sat up.', 666, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('99f350d44f7573dacc7b171bdc285c5d3a4615f846208d22aefca0d881e80484', '“Don’t move,” he said. “The floor is covered with smashed crockery from
the dresser. You can’t possibly move without making a noise, and I
fancy _they_ are outside.”', 667, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('40674114965b1981453b776d2404e8b7baa8d79faedd9fe8255d94f0805b2d9c', 'We both sat quite silent, so that we could scarcely hear each other
breathing. Everything seemed deadly still, but once something near us,
some plaster or broken brickwork, slid down with a rumbling sound.
Outside and very near was an intermittent, metallic rattle.', 668, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ad690fed761e96afa102def7463856fa3f049cb498e63127075b396cf84bf6df', '“That!” said the curate, when presently it happened again.', 669, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e102ec93c63ad875b7287abe05fc106dea4c196df71717d005f81ecfb9a6dce7', '“Yes,” I said. “But what is it?”', 670, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9ac6973b634fd206302f16db0c3288295c350f3b580192881248f7da9b960732', '“A Martian!” said the curate.', 671, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('24673a2afb9ef8992b43ff12811fbca0549caef89c24f2d2ec6a708f57b00a26', 'I listened again.', 672, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('82f4a74d64295ea600a9c04b0578c2223cf5c234846d7a6e5a534303efca00af', '“It was not like the Heat-Ray,” I said, and for a time I was inclined
to think one of the great fighting-machines had stumbled against the
house, as I had seen one stumble against the tower of Shepperton
Church.', 673, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3ced4306d0f55f0972c4b11c89ebc3994d2d6830c5bca74ada534c70a5ea8e24', 'Our situation was so strange and incomprehensible that for three or
four hours, until the dawn came, we scarcely moved. And then the light
filtered in, not through the window, which remained black, but through
a triangular aperture between a beam and a heap of broken bricks in the
wall behind us. The interior of the kitchen we now saw greyly for the
first time.', 674, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ea35bd5a065f8c2a82aeed92b5d0370e3dc30af40bdbc810cc6590357826ad53', 'The cylinder was already opened in the centre of the pit, and on the
farther edge of the pit, amid the smashed and gravel-heaped shrubbery,
one of the great fighting-machines, deserted by its occupant, stood
stiff and tall against the evening sky. At first I scarcely noticed the
pit and the cylinder, although it has been convenient to describe them
first, on account of the extraordinary glittering mechanism I saw busy
in the excavation, and on account of the strange creatures that were
crawling slowly and painfully across the heaped mould near it.', 690, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6c7109f2b4651a41f3a090b1fb2a5008f4d250bf4498406ee779701c25f49643', 'The window had been burst in by a mass of garden mould, which flowed
over the table upon which we had been sitting and lay about our feet.
Outside, the soil was banked high against the house. At the top of the
window frame we could see an uprooted drainpipe. The floor was littered
with smashed hardware; the end of the kitchen towards the house was
broken into, and since the daylight shone in there, it was evident the
greater part of the house had collapsed. Contrasting vividly with this
ruin was the neat dresser, stained in the fashion, pale green, and with
a number of copper and tin vessels below it, the wallpaper imitating
blue and white tiles, and a couple of coloured supplements fluttering
from the walls above the kitchen range.', 675, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3ec6920f812c0d110a9d998d0937fec8ae8c29369f8d3a44996e9fc6b7369eab', 'As the dawn grew clearer, we saw through the gap in the wall the body
of a Martian, standing sentinel, I suppose, over the still glowing
cylinder. At the sight of that we crawled as circumspectly as possible
out of the twilight of the kitchen into the darkness of the scullery.', 676, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e78a4efabc1f61da54559a0480a8c34123ef9f4eabe90745ad6fa263aa4a26bd', 'Abruptly the right interpretation dawned upon my mind.', 677, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9d734b4d66b5a5e192c84ddaf57e80939bb6211a3c8c21cab0546e7ad77b39f6', '“The fifth cylinder,” I whispered, “the fifth shot from Mars, has
struck this house and buried us under the ruins!”', 678, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d871a4e45be4441ca024867d54a22aee0da482709dc5f14fe0d63cba496e6a99', 'For a time the curate was silent, and then he whispered:', 679, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dc48c266352e32003d28fa45333d5e020a85096837b885a6562d156b3461a7bf', '“God have mercy upon us!”', 680, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('beaca19d18dae602a8a884cfef37f961944608d9af3586ee5f0f7a2167681eb4', 'I heard him presently whimpering to himself.', 681, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('51dd3ae4a7e4f25588d37bb27cd2b8c61c1af78112f04e3ef5e6e616b9684bd2', 'Save for that sound we lay quite still in the scullery; I for my part
scarce dared breathe, and sat with my eyes fixed on the faint light of
the kitchen door. I could just see the curate’s face, a dim, oval
shape, and his collar and cuffs. Outside there began a metallic
hammering, then a violent hooting, and then again, after a quiet
interval, a hissing like the hissing of an engine. These noises, for
the most part problematical, continued intermittently, and seemed if
anything to increase in number as time wore on. Presently a measured
thudding and a vibration that made everything about us quiver and the
vessels in the pantry ring and shift, began and continued. Once the
light was eclipsed, and the ghostly kitchen doorway became absolutely
dark. For many hours we must have crouched there, silent and shivering,
until our tired attention failed. . . .', 682, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8d56dc83296d0c8bf265fbd6416810af2c9ea2fdfba320139f8f7d3c5a99b2b5', 'At last I found myself awake and very hungry. I am inclined to believe
we must have spent the greater portion of a day before that awakening.
My hunger was at a stride so insistent that it moved me to action. I
told the curate I was going to seek food, and felt my way towards the
pantry. He made me no answer, but so soon as I began eating the faint
noise I made stirred him up and I heard him crawling after me.', 683, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bd85a6b036acd6427419f891ac97aaca4a421cdd379c8598b20c0f0555c36b99', '', 684, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9903a8442ea2115c7bbc1b5172179241d9bc5aa6ecc5b4abc8bb5b3b0ed99dce', '
II.
WHAT WE SAW FROM THE RUINED HOUSE.', 685, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('df063161c457372e964b9fe634cf8ef3679653ea70d49e6b4beea8b5a68f74e2', '
After eating we crept back to the scullery, and there I must have dozed
again, for when presently I looked round I was alone. The thudding
vibration continued with wearisome persistence. I whispered for the
curate several times, and at last felt my way to the door of the
kitchen. It was still daylight, and I perceived him across the room,
lying against the triangular hole that looked out upon the Martians.
His shoulders were hunched, so that his head was hidden from me.', 686, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1212916050564af15df759965852e96843e222d0a39c40dd63d767b7fdd2d3dc', 'I could hear a number of noises almost like those in an engine shed;
and the place rocked with that beating thud. Through the aperture in
the wall I could see the top of a tree touched with gold and the warm
blue of a tranquil evening sky. For a minute or so I remained watching
the curate, and then I advanced, crouching and stepping with extreme
care amid the broken crockery that littered the floor.', 687, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4b8b34a516499082268fbf487d5f099f2d3d5a38991829ec639127b995589aa5', 'I touched the curate’s leg, and he started so violently that a mass of
plaster went sliding down outside and fell with a loud impact. I
gripped his arm, fearing he might cry out, and for a long time we
crouched motionless. Then I turned to see how much of our rampart
remained. The detachment of the plaster had left a vertical slit open
in the debris, and by raising myself cautiously across a beam I was
able to see out of this gap into what had been overnight a quiet
suburban roadway. Vast, indeed, was the change that we beheld.', 688, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7a2d462c724859834c239e3f4f23caa96537ab4c6d31fce5af31fe28ca8ad081', 'The fifth cylinder must have fallen right into the midst of the house
we had first visited. The building had vanished, completely smashed,
pulverised, and dispersed by the blow. The cylinder lay now far beneath
the original foundations—deep in a hole, already vastly larger than the
pit I had looked into at Woking. The earth all round it had splashed
under that tremendous impact—“splashed” is the only word—and lay in
heaped piles that hid the masses of the adjacent houses. It had behaved
exactly like mud under the violent blow of a hammer. Our house had
collapsed backward; the front portion, even on the ground floor, had
been destroyed completely; by a chance the kitchen and scullery had
escaped, and stood buried now under soil and ruins, closed in by tons
of earth on every side save towards the cylinder. Over that aspect we
hung now on the very edge of the great circular pit the Martians were
engaged in making. The heavy beating sound was evidently just behind
us, and ever and again a bright green vapour drove up like a veil
across our peephole.', 689, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a7d6a49d93bf8aadab06baea0687e98eb0ce9bf1f91bd258b163296bc860c742', '“There is no food about here,” he said. “This is my country. All this
hill down to the river, and back to Clapham, and up to the edge of the
common. There is only food for one. Which way are you going?”', 805, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('72d633e4bc56b7b4437b3600cd39de697e66829237b41b2aabf24244c5d1420f', 'The mechanism it certainly was that held my attention first. It was one
of those complicated fabrics that have since been called
handling-machines, and the study of which has already given such an
enormous impetus to terrestrial invention. As it dawned upon me first,
it presented a sort of metallic spider with five jointed, agile legs,
and with an extraordinary number of jointed levers, bars, and reaching
and clutching tentacles about its body. Most of its arms were
retracted, but with three long tentacles it was fishing out a number of
rods, plates, and bars which lined the covering and apparently
strengthened the walls of the cylinder. These, as it extracted them,
were lifted out and deposited upon a level surface of earth behind it.', 691, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('391fe91c47d8ed9e3f7910a1ad4fecd2f960de309ce4ac75e1f0eb48a420f250', 'Its motion was so swift, complex, and perfect that at first I did not
see it as a machine, in spite of its metallic glitter. The
fighting-machines were coordinated and animated to an extraordinary
pitch, but nothing to compare with this. People who have never seen
these structures, and have only the ill-imagined efforts of artists or
the imperfect descriptions of such eye-witnesses as myself to go upon,
scarcely realise that living quality.', 692, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b0b17670662dad04bbe6256b4f08dcb7c6b72afb142ec0f3c9f5b548adc28d2f', 'I recall particularly the illustration of one of the first pamphlets to
give a consecutive account of the war. The artist had evidently made a
hasty study of one of the fighting-machines, and there his knowledge
ended. He presented them as tilted, stiff tripods, without either
flexibility or subtlety, and with an altogether misleading monotony of
effect. The pamphlet containing these renderings had a considerable
vogue, and I mention them here simply to warn the reader against the
impression they may have created. They were no more like the Martians I
saw in action than a Dutch doll is like a human being. To my mind, the
pamphlet would have been much better without them.', 693, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6a757d0bdfd7d6e414e78cb97362a2a1e79142b3f828d51215880667bd7f91e0', 'At first, I say, the handling-machine did not impress me as a machine,
but as a crablike creature with a glittering integument, the
controlling Martian whose delicate tentacles actuated its movements
seeming to be simply the equivalent of the crab’s cerebral portion. But
then I perceived the resemblance of its grey-brown, shiny, leathery
integument to that of the other sprawling bodies beyond, and the true
nature of this dexterous workman dawned upon me. With that realisation
my interest shifted to those other creatures, the real Martians.
Already I had had a transient impression of these, and the first nausea
no longer obscured my observation. Moreover, I was concealed and
motionless, and under no urgency of action.', 694, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4fde4439b222bdb150b2b1d49eaaffe2af626f68d64e4054e491607b499d842e', 'They were, I now saw, the most unearthly creatures it is possible to
conceive. They were huge round bodies—or, rather, heads—about four feet
in diameter, each body having in front of it a face. This face had no
nostrils—indeed, the Martians do not seem to have had any sense of
smell, but it had a pair of very large dark-coloured eyes, and just
beneath this a kind of fleshy beak. In the back of this head or body—I
scarcely know how to speak of it—was the single tight tympanic surface,
since known to be anatomically an ear, though it must have been almost
useless in our dense air. In a group round the mouth were sixteen
slender, almost whiplike tentacles, arranged in two bunches of eight
each. These bunches have since been named rather aptly, by that
distinguished anatomist, Professor Howes, the _hands_. Even as I saw
these Martians for the first time they seemed to be endeavouring to
raise themselves on these hands, but of course, with the increased
weight of terrestrial conditions, this was impossible. There is reason
to suppose that on Mars they may have progressed upon them with some
facility.', 695, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('06025260f169cb3648be811d3a82c47efe9c7ef8920db3427c54b1b5e1fdca05', 'The internal anatomy, I may remark here, as dissection has since shown,
was almost equally simple. The greater part of the structure was the
brain, sending enormous nerves to the eyes, ear, and tactile tentacles.
Besides this were the bulky lungs, into which the mouth opened, and the
heart and its vessels. The pulmonary distress caused by the denser
atmosphere and greater gravitational attraction was only too evident in
the convulsive movements of the outer skin.', 696, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fda9be0b3ab0e1e92489d66c8846c5b592e5207c01b095cbf77dfc98b87c4e2b', 'And this was the sum of the Martian organs. Strange as it may seem to a
human being, all the complex apparatus of digestion, which makes up the
bulk of our bodies, did not exist in the Martians. They were
heads—merely heads. Entrails they had none. They did not eat, much less
digest. Instead, they took the fresh, living blood of other creatures,
and _injected_ it into their own veins. I have myself seen this being
done, as I shall mention in its place. But, squeamish as I may seem, I
cannot bring myself to describe what I could not endure even to
continue watching. Let it suffice to say, blood obtained from a still
living animal, in most cases from a human being, was run directly by
means of a little pipette into the recipient canal. . . .', 697, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9360a0da22a9050b29a325fc18cc57e1d8765e060746665fd37e8ee05515365e', 'The bare idea of this is no doubt horribly repulsive to us, but at the
same time I think that we should remember how repulsive our carnivorous
habits would seem to an intelligent rabbit.', 698, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a6549eb0ddc2ae410636c482b8507245fdbdbc228386960830d27ee69d00dc17', 'The physiological advantages of the practice of injection are
undeniable, if one thinks of the tremendous waste of human time and
energy occasioned by eating and the digestive process. Our bodies are
half made up of glands and tubes and organs, occupied in turning
heterogeneous food into blood. The digestive processes and their
reaction upon the nervous system sap our strength and colour our minds.
Men go happy or miserable as they have healthy or unhealthy livers, or
sound gastric glands. But the Martians were lifted above all these
organic fluctuations of mood and emotion.', 699, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e52e72fb0e49cb133995c3008a20c320d931a6b20dc87494269d6d2a62be8929', 'Suddenly I heard a noise without, the run and smash of slipping
plaster, and the triangular aperture in the wall was darkened. I looked
up and saw the lower surface of a handling-machine coming slowly across
the hole. One of its gripping limbs curled amid the debris; another
limb appeared, feeling its way over the fallen beams. I stood
petrified, staring. Then I saw through a sort of glass plate near the
edge of the body the face, as we may call it, and the large dark eyes
of a Martian, peering, and then a long metallic snake of tentacle came
feeling slowly through the hole.', 746, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fe6910799c4ecca32d0f1b517f9c718ad913d3de513077a2c42b41c09d8180c8', 'Their undeniable preference for men as their source of nourishment is
partly explained by the nature of the remains of the victims they had
brought with them as provisions from Mars. These creatures, to judge
from the shrivelled remains that have fallen into human hands, were
bipeds with flimsy, silicious skeletons (almost like those of the
silicious sponges) and feeble musculature, standing about six feet high
and having round, erect heads, and large eyes in flinty sockets. Two or
three of these seem to have been brought in each cylinder, and all were
killed before earth was reached. It was just as well for them, for the
mere attempt to stand upright upon our planet would have broken every
bone in their bodies.', 700, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('91fa35ffcde6a545c600d813d8a69a60645531c5af517cd877519546260058a2', 'And while I am engaged in this description, I may add in this place
certain further details which, although they were not all evident to us
at the time, will enable the reader who is unacquainted with them to
form a clearer picture of these offensive creatures.', 701, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('291fd1283ca9cdfdff40c25d4accf9beea73537843697c359e2bfd0e19fec10c', 'In three other points their physiology differed strangely from ours.
Their organisms did not sleep, any more than the heart of man sleeps.
Since they had no extensive muscular mechanism to recuperate, that
periodical extinction was unknown to them. They had little or no sense
of fatigue, it would seem. On earth they could never have moved without
effort, yet even to the last they kept in action. In twenty-four hours
they did twenty-four hours of work, as even on earth is perhaps the
case with the ants.', 702, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9720a18fa57ef0d309182a60e8dbaed9c59c7e850b32bad2618d569e2f3bf54a', 'In the next place, wonderful as it seems in a sexual world, the
Martians were absolutely without sex, and therefore without any of the
tumultuous emotions that arise from that difference among men. A young
Martian, there can now be no dispute, was really born upon earth during
the war, and it was found attached to its parent, partially _budded_
off, just as young lilybulbs bud off, or like the young animals in the
fresh-water polyp.', 703, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('70f8ade095ae76da80ea6f6b2c0a512e382376eaf4fca3ab49e31c9d8a6db549', 'In man, in all the higher terrestrial animals, such a method of
increase has disappeared; but even on this earth it was certainly the
primitive method. Among the lower animals, up even to those first
cousins of the vertebrated animals, the Tunicates, the two processes
occur side by side, but finally the sexual method superseded its
competitor altogether. On Mars, however, just the reverse has
apparently been the case.', 704, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('825e193a9ad65225fdd787e5e2a8f76f1258e7f788ad267df41dfe7e7a779991', 'It is worthy of remark that a certain speculative writer of
quasi-scientific repute, writing long before the Martian invasion, did
forecast for man a final structure not unlike the actual Martian
condition. His prophecy, I remember, appeared in November or December,
1893, in a long-defunct publication, the _Pall Mall Budget_, and I
recall a caricature of it in a pre-Martian periodical called _Punch_.
He pointed out—writing in a foolish, facetious tone—that the perfection
of mechanical appliances must ultimately supersede limbs; the
perfection of chemical devices, digestion; that such organs as hair,
external nose, teeth, ears, and chin were no longer essential parts of
the human being, and that the tendency of natural selection would lie
in the direction of their steady diminution through the coming ages.
The brain alone remained a cardinal necessity. Only one other part of
the body had a strong case for survival, and that was the hand,
“teacher and agent of the brain.” While the rest of the body dwindled,
the hands would grow larger.', 705, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d054206b5e56c8347f86b30df625baf2af9fe39dfd2d9616e3faf4e868c53fe4', 'There is many a true word written in jest, and here in the Martians we
have beyond dispute the actual accomplishment of such a suppression of
the animal side of the organism by the intelligence. To me it is quite
credible that the Martians may be descended from beings not unlike
ourselves, by a gradual development of brain and hands (the latter
giving rise to the two bunches of delicate tentacles at last) at the
expense of the rest of the body. Without the body the brain would, of
course, become a mere selfish intelligence, without any of the
emotional substratum of the human being.', 706, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9b72220398dc901a08d914af443c437f70250972b792c404a98ad7482166dc41', 'The last salient point in which the systems of these creatures differed
from ours was in what one might have thought a very trivial particular.
Micro-organisms, which cause so much disease and pain on earth, have
either never appeared upon Mars or Martian sanitary science eliminated
them ages ago. A hundred diseases, all the fevers and contagions of
human life, consumption, cancers, tumours and such morbidities, never
enter the scheme of their life. And speaking of the differences between
the life on Mars and terrestrial life, I may allude here to the curious
suggestions of the red weed.', 707, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('772f66f179700294ce9e18b68b645e51e49a4eb4ebc7ee2c96bae08cdb75f627', 'Apparently the vegetable kingdom in Mars, instead of having green for a
dominant colour, is of a vivid blood-red tint. At any rate, the seeds
which the Martians (intentionally or accidentally) brought with them
gave rise in all cases to red-coloured growths. Only that known
popularly as the red weed, however, gained any footing in competition
with terrestrial forms. The red creeper was quite a transitory growth,
and few people have seen it growing. For a time, however, the red weed
grew with astonishing vigour and luxuriance. It spread up the sides of
the pit by the third or fourth day of our imprisonment, and its
cactus-like branches formed a carmine fringe to the edges of our
triangular window. And afterwards I found it broadcast throughout the
country, and especially wherever there was a stream of water.', 708, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9c7bcc3bd9601a9de81d782f32aef33d9d938ef92d59dd299d35f68e7498179c', 'And while within we fought out our dark, dim contest of whispers,
snatched food and drink, and gripping hands and blows, without, in the
pitiless sunlight of that terrible June, was the strange wonder, the
unfamiliar routine of the Martians in the pit. Let me return to those
first new experiences of mine. After a long time I ventured back to the
peephole, to find that the new-comers had been reinforced by the
occupants of no fewer than three of the fighting-machines. These last
had brought with them certain fresh appliances that stood in an orderly
manner about the cylinder. The second handling-machine was now
completed, and was busied in serving one of the novel contrivances the
big machine had brought. This was a body resembling a milk can in its
general form, above which oscillated a pear-shaped receptacle, and from
which a stream of white powder flowed into a circular basin below.', 719, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f2e2ffa41e43255d07157a93e2ea81047c753eaecb75038ab8527a931af67508', 'The Martians had what appears to have been an auditory organ, a single
round drum at the back of the head-body, and eyes with a visual range
not very different from ours except that, according to Philips, blue
and violet were as black to them. It is commonly supposed that they
communicated by sounds and tentacular gesticulations; this is asserted,
for instance, in the able but hastily compiled pamphlet (written
evidently by someone not an eye-witness of Martian actions) to which I
have already alluded, and which, so far, has been the chief source of
information concerning them. Now no surviving human being saw so much
of the Martians in action as I did. I take no credit to myself for an
accident, but the fact is so. And I assert that I watched them closely
time after time, and that I have seen four, five, and (once) six of
them sluggishly performing the most elaborately complicated operations
together without either sound or gesture. Their peculiar hooting
invariably preceded feeding; it had no modulation, and was, I believe,
in no sense a signal, but merely the expiration of air preparatory to
the suctional operation. I have a certain claim to at least an
elementary knowledge of psychology, and in this matter I am
convinced—as firmly as I am convinced of anything—that the Martians
interchanged thoughts without any physical intermediation. And I have
been convinced of this in spite of strong preconceptions. Before the
Martian invasion, as an occasional reader here or there may remember, I
had written with some little vehemence against the telepathic theory.', 709, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('47c27c55945531e6caf8c29146a3d451e844cdc2918e026a8181c2e52da65606', 'The Martians wore no clothing. Their conceptions of ornament and
decorum were necessarily different from ours; and not only were they
evidently much less sensible of changes of temperature than we are, but
changes of pressure do not seem to have affected their health at all
seriously. Yet though they wore no clothing, it was in the other
artificial additions to their bodily resources that their great
superiority over man lay. We men, with our bicycles and road-skates,
our Lilienthal soaring-machines, our guns and sticks and so forth, are
just in the beginning of the evolution that the Martians have worked
out. They have become practically mere brains, wearing different bodies
according to their needs just as men wear suits of clothes and take a
bicycle in a hurry or an umbrella in the wet. And of their appliances,
perhaps nothing is more wonderful to a man than the curious fact that
what is the dominant feature of almost all human devices in mechanism
is absent—the _wheel_ is absent; among all the things they brought to
earth there is no trace or suggestion of their use of wheels. One would
have at least expected it in locomotion. And in this connection it is
curious to remark that even on this earth Nature has never hit upon the
wheel, or has preferred other expedients to its development. And not
only did the Martians either not know of (which is incredible), or
abstain from, the wheel, but in their apparatus singularly little use
is made of the fixed pivot or relatively fixed pivot, with circular
motions thereabout confined to one plane. Almost all the joints of the
machinery present a complicated system of sliding parts moving over
small but beautifully curved friction bearings. And while upon this
matter of detail, it is remarkable that the long leverages of their
machines are in most cases actuated by a sort of sham musculature of
the disks in an elastic sheath; these disks become polarised and drawn
closely and powerfully together when traversed by a current of
electricity. In this way the curious parallelism to animal motions,
which was so striking and disturbing to the human beholder, was
attained. Such quasi-muscles abounded in the crablike handling-machine
which, on my first peeping out of the slit, I watched unpacking the
cylinder. It seemed infinitely more alive than the actual Martians
lying beyond it in the sunset light, panting, stirring ineffectual
tentacles, and moving feebly after their vast journey across space.', 710, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cfcfdf04c4c2c61636006618619b09b27af737fe161aa9c4d300685453865304', 'While I was still watching their sluggish motions in the sunlight, and
noting each strange detail of their form, the curate reminded me of his
presence by pulling violently at my arm. I turned to a scowling face,
and silent, eloquent lips. He wanted the slit, which permitted only one
of us to peep through; and so I had to forego watching them for a time
while he enjoyed that privilege.', 711, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('171e7611255daea7fec37442d8f1e833b3577b8e05be1d431abaaab8ec3059e4', 'When I looked again, the busy handling-machine had already put together
several of the pieces of apparatus it had taken out of the cylinder
into a shape having an unmistakable likeness to its own; and down on
the left a busy little digging mechanism had come into view, emitting
jets of green vapour and working its way round the pit, excavating and
embanking in a methodical and discriminating manner. This it was which
had caused the regular beating noise, and the rhythmic shocks that had
kept our ruinous refuge quivering. It piped and whistled as it worked.
So far as I could see, the thing was without a directing Martian at
all.', 712, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ee4273fb39f4f871b0af47c0848c49b74dab08366804dd64fede4424432ed506', '', 713, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7b5a809f51921d2d1274719766758c1d59776f4e1206c24b0eb473022ed883d1', '
III.
THE DAYS OF IMPRISONMENT.', 714, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1ffc76654c2785c6f949f529b12ad4214a23fa417216de3b13b98c61c5c79084', '
The arrival of a second fighting-machine drove us from our peephole
into the scullery, for we feared that from his elevation the Martian
might see down upon us behind our barrier. At a later date we began to
feel less in danger of their eyes, for to an eye in the dazzle of the
sunlight outside our refuge must have been blank blackness, but at
first the slightest suggestion of approach drove us into the scullery
in heart-throbbing retreat. Yet terrible as was the danger we incurred,
the attraction of peeping was for both of us irresistible. And I recall
now with a sort of wonder that, in spite of the infinite danger in
which we were between starvation and a still more terrible death, we
could yet struggle bitterly for that horrible privilege of sight. We
would race across the kitchen in a grotesque way between eagerness and
the dread of making a noise, and strike each other, and thrust and
kick, within a few inches of exposure.', 715, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4640437422857c558e9e6a2278de55fe95e47725d231d02f5acc650268a603c6', 'The fact is that we had absolutely incompatible dispositions and habits
of thought and action, and our danger and isolation only accentuated
the incompatibility. At Halliford I had already come to hate the
curate’s trick of helpless exclamation, his stupid rigidity of mind.
His endless muttering monologue vitiated every effort I made to think
out a line of action, and drove me at times, thus pent up and
intensified, almost to the verge of craziness. He was as lacking in
restraint as a silly woman. He would weep for hours together, and I
verily believe that to the very end this spoiled child of life thought
his weak tears in some way efficacious. And I would sit in the darkness
unable to keep my mind off him by reason of his importunities. He ate
more than I did, and it was in vain I pointed out that our only chance
of life was to stop in the house until the Martians had done with their
pit, that in that long patience a time might presently come when we
should need food. He ate and drank impulsively in heavy meals at long
intervals. He slept little.', 716, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d59511d22e442a6d366f16fc61664f8ec12ec157fd74c07afc2ba39a8c385e9', 'As the days wore on, his utter carelessness of any consideration so
intensified our distress and danger that I had, much as I loathed doing
it, to resort to threats, and at last to blows. That brought him to
reason for a time. But he was one of those weak creatures, void of
pride, timorous, anæmic, hateful souls, full of shifty cunning, who
face neither God nor man, who face not even themselves.', 717, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d9ae4effe02a6522b4ede33873616f18c20c08c3b9729cb8e25ff4b61c4595d7', 'It is disagreeable for me to recall and write these things, but I set
them down that my story may lack nothing. Those who have escaped the
dark and terrible aspects of life will find my brutality, my flash of
rage in our final tragedy, easy enough to blame; for they know what is
wrong as well as any, but not what is possible to tortured men. But
those who have been under the shadow, who have gone down at last to
elemental things, will have a wider charity.', 718, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ce22709febd3a73504fba227cda1d626464a0ab6d7f3714659c07558601dc4a6', 'I put out my hand and felt the meat chopper hanging to the wall. In a
flash I was after him. I was fierce with fear. Before he was halfway
across the kitchen I had overtaken him. With one last touch of humanity
I turned the blade back and struck him with the butt. He went headlong
forward and lay stretched on the ground. I stumbled over him and stood
panting. He lay still.', 745, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2650893bbfc78450a2ca3d80abbaea46c53a4301c23b6d927da912139d7e6cc4', 'I answered slowly.', 806, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('de248dc703e1b841b42dbdd7bd7930394c21fff8b42e24208d2fce9f390b1555', 'The oscillatory motion was imparted to this by one tentacle of the
handling-machine. With two spatulate hands the handling-machine was
digging out and flinging masses of clay into the pear-shaped receptacle
above, while with another arm it periodically opened a door and removed
rusty and blackened clinkers from the middle part of the machine.
Another steely tentacle directed the powder from the basin along a
ribbed channel towards some receiver that was hidden from me by the
mound of bluish dust. From this unseen receiver a little thread of
green smoke rose vertically into the quiet air. As I looked, the
handling-machine, with a faint and musical clinking, extended,
telescopic fashion, a tentacle that had been a moment before a mere
blunt projection, until its end was hidden behind the mound of clay. In
another second it had lifted a bar of white aluminium into sight,
untarnished as yet, and shining dazzlingly, and deposited it in a
growing stack of bars that stood at the side of the pit. Between sunset
and starlight this dexterous machine must have made more than a hundred
such bars out of the crude clay, and the mound of bluish dust rose
steadily until it topped the side of the pit.', 720, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5e0049e84464a5e5e7c34bceca20134d764b4e2769a0f477f4bf4cc16c4c67a9', 'The contrast between the swift and complex movements of these
contrivances and the inert panting clumsiness of their masters was
acute, and for days I had to tell myself repeatedly that these latter
were indeed the living of the two things.', 721, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f19d36776a0be7209bac80acc16ad9888a63cbd7419424eacf79950834544da5', 'The curate had possession of the slit when the first men were brought
to the pit. I was sitting below, huddled up, listening with all my
ears. He made a sudden movement backward, and I, fearful that we were
observed, crouched in a spasm of terror. He came sliding down the
rubbish and crept beside me in the darkness, inarticulate,
gesticulating, and for a moment I shared his panic. His gesture
suggested a resignation of the slit, and after a little while my
curiosity gave me courage, and I rose up, stepped across him, and
clambered up to it. At first I could see no reason for his frantic
behaviour. The twilight had now come, the stars were little and faint,
but the pit was illuminated by the flickering green fire that came from
the aluminium-making. The whole picture was a flickering scheme of
green gleams and shifting rusty black shadows, strangely trying to the
eyes. Over and through it all went the bats, heeding it not at all. The
sprawling Martians were no longer to be seen, the mound of blue-green
powder had risen to cover them from sight, and a fighting-machine, with
its legs contracted, crumpled, and abbreviated, stood across the corner
of the pit. And then, amid the clangour of the machinery, came a
drifting suspicion of human voices, that I entertained at first only to
dismiss.', 722, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fe96b282479943b38ceac360135a651a33e5105c9ddad5f067947cea103c1a83', 'I crouched, watching this fighting-machine closely, satisfying myself
now for the first time that the hood did indeed contain a Martian. As
the green flames lifted I could see the oily gleam of his integument
and the brightness of his eyes. And suddenly I heard a yell, and saw a
long tentacle reaching over the shoulder of the machine to the little
cage that hunched upon its back. Then something—something struggling
violently—was lifted high against the sky, a black, vague enigma
against the starlight; and as this black object came down again, I saw
by the green brightness that it was a man. For an instant he was
clearly visible. He was a stout, ruddy, middle-aged man, well dressed;
three days before, he must have been walking the world, a man of
considerable consequence. I could see his staring eyes and gleams of
light on his studs and watch chain. He vanished behind the mound, and
for a moment there was silence. And then began a shrieking and a
sustained and cheerful hooting from the Martians.', 723, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0e2f76d43b738d67496f11b9a1a6ffc54109b7c404fb026830d72ea779e3d0fd', 'I slid down the rubbish, struggled to my feet, clapped my hands over my
ears, and bolted into the scullery. The curate, who had been crouching
silently with his arms over his head, looked up as I passed, cried out
quite loudly at my desertion of him, and came running after me.', 724, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('59df7a0cb0d6850c74b90032ce3a43675710a93489c209a41d842a277c6632ec', 'That night, as we lurked in the scullery, balanced between our horror
and the terrible fascination this peeping had, although I felt an
urgent need of action I tried in vain to conceive some plan of escape;
but afterwards, during the second day, I was able to consider our
position with great clearness. The curate, I found, was quite incapable
of discussion; this new and culminating atrocity had robbed him of all
vestiges of reason or forethought. Practically he had already sunk to
the level of an animal. But as the saying goes, I gripped myself with
both hands. It grew upon my mind, once I could face the facts, that
terrible as our position was, there was as yet no justification for
absolute despair. Our chief chance lay in the possibility of the
Martians making the pit nothing more than a temporary encampment. Or
even if they kept it permanently, they might not consider it necessary
to guard it, and a chance of escape might be afforded us. I also
weighed very carefully the possibility of our digging a way out in a
direction away from the pit, but the chances of our emerging within
sight of some sentinel fighting-machine seemed at first too great. And
I should have had to do all the digging myself. The curate would
certainly have failed me.', 725, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1ffb7830c0f30093b927d8f05c3af31cc22ab9a66f1a731ca9cff50007194c16', 'It was on the third day, if my memory serves me right, that I saw the
lad killed. It was the only occasion on which I actually saw the
Martians feed. After that experience I avoided the hole in the wall for
the better part of a day. I went into the scullery, removed the door,
and spent some hours digging with my hatchet as silently as possible;
but when I had made a hole about a couple of feet deep the loose earth
collapsed noisily, and I did not dare continue. I lost heart, and lay
down on the scullery floor for a long time, having no spirit even to
move. And after that I abandoned altogether the idea of escaping by
excavation.', 726, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d09a2066f94abc9eca43da56cb2bf6ab2b8947d403842a9236c31ad1fb450564', 'It says much for the impression the Martians had made upon me that at
first I entertained little or no hope of our escape being brought about
by their overthrow through any human effort. But on the fourth or fifth
night I heard a sound like heavy guns.', 727, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('56ca9060e9da19b6bc87e776da312ded45dfce69d2a4478a2e0f71b4d5357808', '“I don’t know,” I said. “I have been buried in the ruins of a house
thirteen or fourteen days. I don’t know what has happened.”', 807, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a6102ee70f62c49ac522a7d97f7c40c5633f79eab5fe64a448651b77c1477e65', 'He looked at me doubtfully, then started, and looked with a changed
expression.', 808, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a5ecec4d7f5fd2c1e2ff8c6e2269d6584490861d12fc19458348ab520aa81fcf', 'It was very late in the night, and the moon was shining brightly. The
Martians had taken away the excavating-machine, and, save for a
fighting-machine that stood in the remoter bank of the pit and a
handling-machine that was buried out of my sight in a corner of the pit
immediately beneath my peephole, the place was deserted by them. Except
for the pale glow from the handling-machine and the bars and patches of
white moonlight the pit was in darkness, and, except for the clinking
of the handling-machine, quite still. That night was a beautiful
serenity; save for one planet, the moon seemed to have the sky to
herself. I heard a dog howling, and that familiar sound it was that
made me listen. Then I heard quite distinctly a booming exactly like
the sound of great guns. Six distinct reports I counted, and after a
long interval six again. And that was all.', 728, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6c42e721a961f7640e71810a84b5b1cca2be3f7596cecf685b3c6a49e2ea6a6b', '', 729, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7396bacfe371dc1afd5191e907cda929e9560f6fde56e193a23bb8ef3a890d60', '
IV.
THE DEATH OF THE CURATE.', 730, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c221fc166f8328ab6d88174c392934eb65dcf127faf7b14d0c609832adf5aa4e', '
It was on the sixth day of our imprisonment that I peeped for the last
time, and presently found myself alone. Instead of keeping close to me
and trying to oust me from the slit, the curate had gone back into the
scullery. I was struck by a sudden thought. I went back quickly and
quietly into the scullery. In the darkness I heard the curate drinking.
I snatched in the darkness, and my fingers caught a bottle of burgundy.', 731, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e24cbccd4576ae85624e7f2c16697c6792187dbce454d26189fb7e4383cb228a', 'For a few minutes there was a tussle. The bottle struck the floor and
broke, and I desisted and rose. We stood panting and threatening each
other. In the end I planted myself between him and the food, and told
him of my determination to begin a discipline. I divided the food in
the pantry, into rations to last us ten days. I would not let him eat
any more that day. In the afternoon he made a feeble effort to get at
the food. I had been dozing, but in an instant I was awake. All day and
all night we sat face to face, I weary but resolute, and he weeping and
complaining of his immediate hunger. It was, I know, a night and a day,
but to me it seemed—it seems now—an interminable length of time.', 732, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8a6464477568c8c725f97d88f1d4a763df553f3588daf6f149dff595af56b38d', 'And so our widened incompatibility ended at last in open conflict. For
two vast days we struggled in undertones and wrestling contests. There
were times when I beat and kicked him madly, times when I cajoled and
persuaded him, and once I tried to bribe him with the last bottle of
burgundy, for there was a rain-water pump from which I could get water.
But neither force nor kindness availed; he was indeed beyond reason. He
would neither desist from his attacks on the food nor from his noisy
babbling to himself. The rudimentary precautions to keep our
imprisonment endurable he would not observe. Slowly I began to realise
the complete overthrow of his intelligence, to perceive that my sole
companion in this close and sickly darkness was a man insane.', 733, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fdbf219c74896ebbe73eb05bf9717d22344d95b2f3734cec7521e64c4f4167d0', 'From certain vague memories I am inclined to think my own mind wandered
at times. I had strange and hideous dreams whenever I slept. It sounds
paradoxical, but I am inclined to think that the weakness and insanity
of the curate warned me, braced me, and kept me a sane man.', 734, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('43c97923de920a352735c75aa545e1f9ed28e6e22d342402d053c4453e0b8c0f', 'On the eighth day he began to talk aloud instead of whispering, and
nothing I could do would moderate his speech.', 735, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6a685a9f63407b1b5ad06673aab04e3ed8e350d2e93beebcd02854efc27bcc55', '“It is just, O God!” he would say, over and over again. “It is just. On
me and mine be the punishment laid. We have sinned, we have fallen
short. There was poverty, sorrow; the poor were trodden in the dust,
and I held my peace. I preached acceptable folly—my God, what
folly!—when I should have stood up, though I died for it, and called
upon them to repent—repent! . . . Oppressors of the poor and needy . .
. ! The wine press of God!”', 736, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e86e2005455c00f32d3bc2292bc203428f9aaa94460940fb8c9acf8d5e8d377b', 'Then he would suddenly revert to the matter of the food I withheld from
him, praying, begging, weeping, at last threatening. He began to raise
his voice—I prayed him not to. He perceived a hold on me—he threatened
he would shout and bring the Martians upon us. For a time that scared
me; but any concession would have shortened our chance of escape beyond
estimating. I defied him, although I felt no assurance that he might
not do this thing. But that day, at any rate, he did not. He talked
with his voice rising slowly, through the greater part of the eighth
and ninth days—threats, entreaties, mingled with a torrent of half-sane
and always frothy repentance for his vacant sham of God’s service, such
as made me pity him. Then he slept awhile, and began again with renewed
strength, so loudly that I must needs make him desist.', 737, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9a1680b91101e49d892418009b494deb818de93f94fb51317ac68ba1af648136', '“Be still!” I implored.', 738, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('00c35a0dcaeacc0f8d0bf87bcfe8a9b460e2a61033df8c7a5e70211e429b1ff4', 'He rose to his knees, for he had been sitting in the darkness near the
copper.', 739, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0a17bbd213556ecd66dc0d3d23d6e6fcb474f013d3ec326bd2209c72b8a10fea', '“I have been still too long,” he said, in a tone that must have reached
the pit, “and now I must bear my witness. Woe unto this unfaithful
city! Woe! Woe! Woe! Woe! Woe! To the inhabitants of the earth by
reason of the other voices of the trumpet——”', 740, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('97c344eacb844a8943b8ce86c76bcb994d158f3c79dae101ac362b07db2fb9df', '“Shut up!” I said, rising to my feet, and in a terror lest the Martians
should hear us. “For God’s sake——”', 741, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('99326a4e064eee244bf5dc0f074327db0701e665ad693361a9162f579ad74337', '“Nay,” shouted the curate, at the top of his voice, standing likewise
and extending his arms. “Speak! The word of the Lord is upon me!”', 742, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f1b0afc654232adbbc227f9afa01ac9f3df8cce9d9165b198981c4b0b0af9bd5', 'In three strides he was at the door leading into the kitchen.', 743, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a7824694c6252f8cd9af03c865be40f3b8144a66fb172b89e7c9b308be8313cc', '“I must bear my witness! I go! It has already been too long delayed.”', 744, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ef8dcc45fc8b2b656281a1ba5c566e66759f05a2a771206ab01f0b9c2e593c5a', 'I turned by an effort, stumbled over the curate, and stopped at the
scullery door. The tentacle was now some way, two yards or more, in the
room, and twisting and turning, with queer sudden movements, this way
and that. For a while I stood fascinated by that slow, fitful advance.
Then, with a faint, hoarse cry, I forced myself across the scullery. I
trembled violently; I could scarcely stand upright. I opened the door
of the coal cellar, and stood there in the darkness staring at the
faintly lit doorway into the kitchen, and listening. Had the Martian
seen me? What was it doing now?', 747, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6f71d2065c1d4dc112403a327d70571256f5572449b00f2e48370a83fa994143', 'Something was moving to and fro there, very quietly; every now and then
it tapped against the wall, or started on its movements with a faint
metallic ringing, like the movements of keys on a split-ring. Then a
heavy body—I knew too well what—was dragged across the floor of the
kitchen towards the opening. Irresistibly attracted, I crept to the
door and peeped into the kitchen. In the triangle of bright outer
sunlight I saw the Martian, in its Briareus of a handling-machine,
scrutinizing the curate’s head. I thought at once that it would infer
my presence from the mark of the blow I had given him.', 748, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d48269111b687a2b1f3419c139daf5559cfd906770efdd607a73cb5ad7ad6201', 'I crept back to the coal cellar, shut the door, and began to cover
myself up as much as I could, and as noiselessly as possible in the
darkness, among the firewood and coal therein. Every now and then I
paused, rigid, to hear if the Martian had thrust its tentacles through
the opening again.', 749, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('587a97167a389a9d4c120d3e2cb021853b07a9101bb4407706da44ed8b1c46b2', 'Then the faint metallic jingle returned. I traced it slowly feeling
over the kitchen. Presently I heard it nearer—in the scullery, as I
judged. I thought that its length might be insufficient to reach me. I
prayed copiously. It passed, scraping faintly across the cellar door.
An age of almost intolerable suspense intervened; then I heard it
fumbling at the latch! It had found the door! The Martians understood
doors!', 750, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4a12300d1e1d8170838f46eaa0ac7d934f6354ec75de80dce1830d140b3ab42', 'It worried at the catch for a minute, perhaps, and then the door
opened.', 751, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7778e411c145c5ed61f3843f3b6c0a2eb80a414808312b3d4f231891d1fbad57', 'In the darkness I could just see the thing—like an elephant’s trunk
more than anything else—waving towards me and touching and examining
the wall, coals, wood and ceiling. It was like a black worm swaying its
blind head to and fro.', 752, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d40fcdaffc6d771eb5629709e8e68c117a77c39dab4bc2166116743c34d4699', 'Once, even, it touched the heel of my boot. I was on the verge of
screaming; I bit my hand. For a time the tentacle was silent. I could
have fancied it had been withdrawn. Presently, with an abrupt click, it
gripped something—I thought it had me!—and seemed to go out of the
cellar again. For a minute I was not sure. Apparently it had taken a
lump of coal to examine.', 753, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e96de77fd6d7d9b7442ebce95db53c75541ea79011976bc23bd82c53b9aaecdb', 'I seized the opportunity of slightly shifting my position, which had
become cramped, and then listened. I whispered passionate prayers for
safety.', 754, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ce8654ea5a9f59094cc66f25c3cdefebf1bfd74494075d048a090e4f20b07340', 'Then I heard the slow, deliberate sound creeping towards me again.
Slowly, slowly it drew near, scratching against the walls and tapping
the furniture.', 755, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3eecfdeb1b076f04c864ce29da4ed52ead6128dd997338e5bf5deb9fc19fa5c4', 'While I was still doubtful, it rapped smartly against the cellar door
and closed it. I heard it go into the pantry, and the biscuit-tins
rattled and a bottle smashed, and then came a heavy bump against the
cellar door. Then silence that passed into an infinity of suspense.', 756, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('54928cc225ff4d530f027ca68b3bae297b63bea8e15ca90720235508eb6bb601', 'Had it gone?', 757, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('20f29bdb67d4e912c1b94237cbdd106d4e7cf963dc63fa1e1339520fe3b9838f', 'At last I decided that it had.', 758, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('557b49d09ae1674cf800c0d8e6a4cfa7bdc2ad7fb520b1b61b3b387c51af4e7d', 'It came into the scullery no more; but I lay all the tenth day in the
close darkness, buried among coals and firewood, not daring even to
crawl out for the drink for which I craved. It was the eleventh day
before I ventured so far from my security.', 759, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7d939fd59d775c89a7cf5ef9a7c17652c1ddf3e457fc53278eebc41c46423436', '', 760, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f430264cf6347d374f3528d3c5d8149493cfc5bea9d4425040891c4a660babfc', '
V.
THE STILLNESS.', 761, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b28ad83a9d15ed7a35ea3c68d4c699f95ed85b7b5169a67cee9651f2ce72a38d', '
My first act before I went into the pantry was to fasten the door
between the kitchen and the scullery. But the pantry was empty; every
scrap of food had gone. Apparently, the Martian had taken it all on the
previous day. At that discovery I despaired for the first time. I took
no food, or no drink either, on the eleventh or the twelfth day.', 762, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3bcf63ef88b6cdacf50cd2eead5e443fb686fe37671a633df09d6a2b83350eea', 'At first my mouth and throat were parched, and my strength ebbed
sensibly. I sat about in the darkness of the scullery, in a state of
despondent wretchedness. My mind ran on eating. I thought I had become
deaf, for the noises of movement I had been accustomed to hear from the
pit had ceased absolutely. I did not feel strong enough to crawl
noiselessly to the peephole, or I would have gone there.', 763, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e60027777314c85ed4194b73585eea742190a3e124f5ced5a60e375f0bdf4708', 'On the twelfth day my throat was so painful that, taking the chance of
alarming the Martians, I attacked the creaking rain-water pump that
stood by the sink, and got a couple of glassfuls of blackened and
tainted rain water. I was greatly refreshed by this, and emboldened by
the fact that no enquiring tentacle followed the noise of my pumping.', 764, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e41ed362d1fed0462cd9a0ad12a6c9a1c349cac01aff6763b9d1f55af8949f7b', 'During these days, in a rambling, inconclusive way, I thought much of
the curate and of the manner of his death.', 765, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('43500bf93f10e54d2c1d33b908c89462942bf975028e6c3db885ecadd4423844', 'Natural Language Processing', 33, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('3ea6ffb1092c81102ed453246bf1417e7891694a11002c89381d7729cecfd978', 'On the thirteenth day I drank some more water, and dozed and thought
disjointedly of eating and of vague impossible plans of escape.
Whenever I dozed I dreamt of horrible phantasms, of the death of the
curate, or of sumptuous dinners; but, asleep or awake, I felt a keen
pain that urged me to drink again and again. The light that came into
the scullery was no longer grey, but red. To my disordered imagination
it seemed the colour of blood.', 766, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c96f52c1b2705a06aedbf5b334407a3bdf093b70dc2cd1bef7ae16164c760e62', 'On the fourteenth day I went into the kitchen, and I was surprised to
find that the fronds of the red weed had grown right across the hole in
the wall, turning the half-light of the place into a crimson-coloured
obscurity.', 767, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5f5fb122f50c3f0003424d8faa02bfe664063369d2f1d86f35ad98689a98b0db', 'It was early on the fifteenth day that I heard a curious, familiar
sequence of sounds in the kitchen, and, listening, identified it as the
snuffing and scratching of a dog. Going into the kitchen, I saw a dog’s
nose peering in through a break among the ruddy fronds. This greatly
surprised me. At the scent of me he barked shortly.', 768, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('92578b5aec125e8fba0237283d32f43ad3604c24a51ddb249e262249ab619388', 'I thought if I could induce him to come into the place quietly I should
be able, perhaps, to kill and eat him; and in any case, it would be
advisable to kill him, lest his actions attracted the attention of the
Martians.', 769, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a0869eaf089cf085d7456859ee085d39dee77f44e9ed5e8c5b330270dd6f114c', 'I crept forward, saying “Good dog!” very softly; but he suddenly
withdrew his head and disappeared.', 770, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bb229568938ca35151dd5e17e2b860e31c4b952b5ae07f34813baccf0cf1cb08', 'I listened—I was not deaf—but certainly the pit was still. I heard a
sound like the flutter of a bird’s wings, and a hoarse croaking, but
that was all.', 771, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a59cbc004153fc188ca9b8f1fb0065b2d0376145a81360b981cdfbf2abd6b11b', 'For a long while I lay close to the peephole, but not daring to move
aside the red plants that obscured it. Once or twice I heard a faint
pitter-patter like the feet of the dog going hither and thither on the
sand far below me, and there were more birdlike sounds, but that was
all. At length, encouraged by the silence, I looked out.', 772, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1ad2f8de290bac1f2e8ea5af1713d8ed24524dcda59a4b6c3d986560d9352a0e', 'Except in the corner, where a multitude of crows hopped and fought over
the skeletons of the dead the Martians had consumed, there was not a
living thing in the pit.', 773, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('198c599abb597567368a22295b9cb39b0390507f88c002e5f9011122f16bbed1', 'I stared about me, scarcely believing my eyes. All the machinery had
gone. Save for the big mound of greyish-blue powder in one corner,
certain bars of aluminium in another, the black birds, and the
skeletons of the killed, the place was merely an empty circular pit in
the sand.', 774, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1c1e43be15e43d247ec795585e51e37c4c6a083a8a5017013c0c04bf0d7185d5', 'Slowly I thrust myself out through the red weed, and stood upon the
mound of rubble. I could see in any direction save behind me, to the
north, and neither Martians nor sign of Martians were to be seen. The
pit dropped sheerly from my feet, but a little way along the rubbish
afforded a practicable slope to the summit of the ruins. My chance of
escape had come. I began to tremble.', 775, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cb0bc2ba687c7c01c83c377d840051f8ab089f6ab77383951d2ce6b671fda2ff', 'I hesitated for some time, and then, in a gust of desperate resolution,
and with a heart that throbbed violently, I scrambled to the top of the
mound in which I had been buried so long.', 776, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ef799ad29409b08c7006fa6050e87e876badca630e1f6a015128cff299fd9acd', 'I looked about again. To the northward, too, no Martian was visible.', 777, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('beb8f2b9b1aa198865615d814183a1d17b7a0129f136f8822b3ae0fe2272c9f0', 'When I had last seen this part of Sheen in the daylight it had been a
straggling street of comfortable white and red houses, interspersed
with abundant shady trees. Now I stood on a mound of smashed brickwork,
clay, and gravel, over which spread a multitude of red cactus-shaped
plants, knee-high, without a solitary terrestrial growth to dispute
their footing. The trees near me were dead and brown, but further a
network of red thread scaled the still living stems.', 778, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0640648019e1faa20da1c8041f62266aaa77074c5dd17ee63f0b7358a6d13699', 'The neighbouring houses had all been wrecked, but none had been burned;
their walls stood, sometimes to the second story, with smashed windows
and shattered doors. The red weed grew tumultuously in their roofless
rooms. Below me was the great pit, with the crows struggling for its
refuse. A number of other birds hopped about among the ruins. Far away
I saw a gaunt cat slink crouchingly along a wall, but traces of men
there were none.', 779, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5cd590f114b6d902521f83412e0efaad2d3dd5ebd6bb740930f6dc1b8b300574', 'The day seemed, by contrast with my recent confinement, dazzlingly
bright, the sky a glowing blue. A gentle breeze kept the red weed that
covered every scrap of unoccupied ground gently swaying. And oh! the
sweetness of the air!', 780, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f0444e91fcb678e08659293d445113dd2a21a89c9e371faa40fb82de25bf175a', '', 781, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('49a6ace3fda3e16c4bc261fca7779ab46f34aa1a4301e4b895f6f999997382a7', '
VI.
THE WORK OF FIFTEEN DAYS.', 782, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4b529cdfa7d1d8a3eefdbed74123a7dca39433625ca4a6af5e791ee914dcdb08', '
For some time I stood tottering on the mound regardless of my safety.
Within that noisome den from which I had emerged I had thought with a
narrow intensity only of our immediate security. I had not realised
what had been happening to the world, had not anticipated this
startling vision of unfamiliar things. I had expected to see Sheen in
ruins—I found about me the landscape, weird and lurid, of another
planet.', 783, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('df245809f4d76145d9a237e8044200e1856141da16963119fb70ad4a4c8ca789', '“I’ve no wish to stop about here,” said I. “I think I shall go to
Leatherhead, for my wife was there.”', 809, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('99b2bb93012ed11d74fec431974ab02a964386c844f38ab4fe2743c62d13551d', 'He shot out a pointing finger.', 810, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e29963f460b60f6234d42041f04b8ebac8fc65778273e1265ef66807abf6d2ff', 'For that moment I touched an emotion beyond the common range of men,
yet one that the poor brutes we dominate know only too well. I felt as
a rabbit might feel returning to his burrow and suddenly confronted by
the work of a dozen busy navvies digging the foundations of a house. I
felt the first inkling of a thing that presently grew quite clear in my
mind, that oppressed me for many days, a sense of dethronement, a
persuasion that I was no longer a master, but an animal among the
animals, under the Martian heel. With us it would be as with them, to
lurk and watch, to run and hide; the fear and empire of man had passed
away.', 784, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9ab6bd09bdcd5eca53941cf93c9f0dd01b4ed8981ac4348c82e487ac7c10ec14', 'But so soon as this strangeness had been realised it passed, and my
dominant motive became the hunger of my long and dismal fast. In the
direction away from the pit I saw, beyond a red-covered wall, a patch
of garden ground unburied. This gave me a hint, and I went knee-deep,
and sometimes neck-deep, in the red weed. The density of the weed gave
me a reassuring sense of hiding. The wall was some six feet high, and
when I attempted to clamber it I found I could not lift my feet to the
crest. So I went along by the side of it, and came to a corner and a
rockwork that enabled me to get to the top, and tumble into the garden
I coveted. Here I found some young onions, a couple of gladiolus bulbs,
and a quantity of immature carrots, all of which I secured, and,
scrambling over a ruined wall, went on my way through scarlet and
crimson trees towards Kew—it was like walking through an avenue of
gigantic blood drops—possessed with two ideas: to get more food, and to
limp, as soon and as far as my strength permitted, out of this accursed
unearthly region of the pit.', 785, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2e9bb011c688c3a34d11e97fd8954f773dff4458665a2d9e0543b6624854a304', 'Some way farther, in a grassy place, was a group of mushrooms which
also I devoured, and then I came upon a brown sheet of flowing shallow
water, where meadows used to be. These fragments of nourishment served
only to whet my hunger. At first I was surprised at this flood in a
hot, dry summer, but afterwards I discovered that it was caused by the
tropical exuberance of the red weed. Directly this extraordinary growth
encountered water it straightway became gigantic and of unparalleled
fecundity. Its seeds were simply poured down into the water of the Wey
and Thames, and its swiftly growing and Titanic water fronds speedily
choked both those rivers.', 786, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8b7198965e27bb839574bc59b665cc0df613c3cb1256d8078931e195092e3dad', 'At Putney, as I afterwards saw, the bridge was almost lost in a tangle
of this weed, and at Richmond, too, the Thames water poured in a broad
and shallow stream across the meadows of Hampton and Twickenham. As the
water spread the weed followed them, until the ruined villas of the
Thames valley were for a time lost in this red swamp, whose margin I
explored, and much of the desolation the Martians had caused was
concealed.', 787, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1c62ee20da933e186c3192a31377e074401c91cd45f9da19b1f6b22478019ac7', 'In the end the red weed succumbed almost as quickly as it had spread. A
cankering disease, due, it is believed, to the action of certain
bacteria, presently seized upon it. Now by the action of natural
selection, all terrestrial plants have acquired a resisting power
against bacterial diseases—they never succumb without a severe
struggle, but the red weed rotted like a thing already dead. The fronds
became bleached, and then shrivelled and brittle. They broke off at the
least touch, and the waters that had stimulated their early growth
carried their last vestiges out to sea.', 788, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3aaaa0f2658656412671a6dd78daef5920a69f3adeb65384f20b5113088fbec7', 'My first act on coming to this water was, of course, to slake my
thirst. I drank a great deal of it and, moved by an impulse, gnawed
some fronds of red weed; but they were watery, and had a sickly,
metallic taste. I found the water was sufficiently shallow for me to
wade securely, although the red weed impeded my feet a little; but the
flood evidently got deeper towards the river, and I turned back to
Mortlake. I managed to make out the road by means of occasional ruins
of its villas and fences and lamps, and so presently I got out of this
spate and made my way to the hill going up towards Roehampton and came
out on Putney Common.', 789, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('10db9fa6df84dc42f86f7e61ef798de042da6a3cc463cca1cac14cc1a5c739f9', 'Here the scenery changed from the strange and unfamiliar to the
wreckage of the familiar: patches of ground exhibited the devastation
of a cyclone, and in a few score yards I would come upon perfectly
undisturbed spaces, houses with their blinds trimly drawn and doors
closed, as if they had been left for a day by the owners, or as if
their inhabitants slept within. The red weed was less abundant; the
tall trees along the lane were free from the red creeper. I hunted for
food among the trees, finding nothing, and I also raided a couple of
silent houses, but they had already been broken into and ransacked. I
rested for the remainder of the daylight in a shrubbery, being, in my
enfeebled condition, too fatigued to push on.', 790, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('908cc028ccd655bf4cea35f25b9631a57da65a1827b65fdbe069ef4c7578a710', 'All this time I saw no human beings, and no signs of the Martians. I
encountered a couple of hungry-looking dogs, but both hurried
circuitously away from the advances I made them. Near Roehampton I had
seen two human skeletons—not bodies, but skeletons, picked clean—and in
the wood by me I found the crushed and scattered bones of several cats
and rabbits and the skull of a sheep. But though I gnawed parts of
these in my mouth, there was nothing to be got from them.', 791, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a7672446c92b7cdc86012644d81dd2c7fbe83b4bf0b79cad69370a99f2ee338f', 'After sunset I struggled on along the road towards Putney, where I
think the Heat-Ray must have been used for some reason. And in the
garden beyond Roehampton I got a quantity of immature potatoes,
sufficient to stay my hunger. From this garden one looked down upon
Putney and the river. The aspect of the place in the dusk was
singularly desolate: blackened trees, blackened, desolate ruins, and
down the hill the sheets of the flooded river, red-tinged with the
weed. And over all—silence. It filled me with indescribable terror to
think how swiftly that desolating change had come.', 792, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7bb8a6bcdc0853cdd7c59b5b0f2a60a8b368a99f29e94c122b4d4cb7912e27c6', 'As I drew nearer I perceived he was dressed in clothes as dusty and
filthy as my own; he looked, indeed, as though he had been dragged
through a culvert. Nearer, I distinguished the green slime of ditches
mixing with the pale drab of dried clay and shiny, coaly patches. His
black hair fell over his eyes, and his face was dark and dirty and
sunken, so that at first I did not recognise him. There was a red cut
across the lower part of his face.', 801, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6f22ef6b1344961f9dd85a489bcf0e54b5bc6d9f825e3172e614b45777996bfb', 'For a time I believed that mankind had been swept out of existence, and
that I stood there alone, the last man left alive. Hard by the top of
Putney Hill I came upon another skeleton, with the arms dislocated and
removed several yards from the rest of the body. As I proceeded I
became more and more convinced that the extermination of mankind was,
save for such stragglers as myself, already accomplished in this part
of the world. The Martians, I thought, had gone on and left the country
desolated, seeking food elsewhere. Perhaps even now they were
destroying Berlin or Paris, or it might be they had gone northward.', 793, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ae485ea32dbdf13de75d23a6ad59bb11465322b8aeece9257de4cabd1da792b4', '', 794, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fd44cf7f8b193caca7cea7a0ddd71bc95247b1d29df408b34fa078182f4e8148', '
VII.
THE MAN ON PUTNEY HILL.', 795, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d333423bc348deee00cae8fc9f98f285d05da1de1bb46528f8d36d85fd2403c6', '
I spent that night in the inn that stands at the top of Putney Hill,
sleeping in a made bed for the first time since my flight to
Leatherhead. I will not tell the needless trouble I had breaking into
that house—afterwards I found the front door was on the latch—nor how I
ransacked every room for food, until just on the verge of despair, in
what seemed to me to be a servant’s bedroom, I found a rat-gnawed crust
and two tins of pineapple. The place had been already searched and
emptied. In the bar I afterwards found some biscuits and sandwiches
that had been overlooked. The latter I could not eat, they were too
rotten, but the former not only stayed my hunger, but filled my
pockets. I lit no lamps, fearing some Martian might come beating that
part of London for food in the night. Before I went to bed I had an
interval of restlessness, and prowled from window to window, peering
out for some sign of these monsters. I slept little. As I lay in bed I
found myself thinking consecutively—a thing I do not remember to have
done since my last argument with the curate. During all the intervening
time my mental condition had been a hurrying succession of vague
emotional states or a sort of stupid receptivity. But in the night my
brain, reinforced, I suppose, by the food I had eaten, grew clear
again, and I thought.', 796, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f58ddd97a15aef2518683921e60892af9336535ca4bffef23828ef83d2f8ece6', 'Three things struggled for possession of my mind: the killing of the
curate, the whereabouts of the Martians, and the possible fate of my
wife. The former gave me no sensation of horror or remorse to recall; I
saw it simply as a thing done, a memory infinitely disagreeable but
quite without the quality of remorse. I saw myself then as I see myself
now, driven step by step towards that hasty blow, the creature of a
sequence of accidents leading inevitably to that. I felt no
condemnation; yet the memory, static, unprogressive, haunted me. In the
silence of the night, with that sense of the nearness of God that
sometimes comes into the stillness and the darkness, I stood my trial,
my only trial, for that moment of wrath and fear. I retraced every step
of our conversation from the moment when I had found him crouching
beside me, heedless of my thirst, and pointing to the fire and smoke
that streamed up from the ruins of Weybridge. We had been incapable of
co-operation—grim chance had taken no heed of that. Had I foreseen, I
should have left him at Halliford. But I did not foresee; and crime is
to foresee and do. And I set this down as I have set all this story
down, as it was. There were no witnesses—all these things I might have
concealed. But I set it down, and the reader must form his judgment as
he will.', 797, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ec2cfb81d4f3c23f992b7e2dc078b7fba97ce320d5ec69bcc597df457b16fbda', 'And when, by an effort, I had set aside that picture of a prostrate
body, I faced the problem of the Martians and the fate of my wife. For
the former I had no data; I could imagine a hundred things, and so,
unhappily, I could for the latter. And suddenly that night became
terrible. I found myself sitting up in bed, staring at the dark. I
found myself praying that the Heat-Ray might have suddenly and
painlessly struck her out of being. Since the night of my return from
Leatherhead I had not prayed. I had uttered prayers, fetish prayers,
had prayed as heathens mutter charms when I was in extremity; but now I
prayed indeed, pleading steadfastly and sanely, face to face with the
darkness of God. Strange night! Strangest in this, that so soon as dawn
had come, I, who had talked with God, crept out of the house like a rat
leaving its hiding place—a creature scarcely larger, an inferior
animal, a thing that for any passing whim of our masters might be
hunted and killed. Perhaps they also prayed confidently to God. Surely,
if we have learned nothing else, this war has taught us pity—pity for
those witless souls that suffer our dominion.', 798, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4b8696ba6b7db2d5daa657a5bd3fddec285e180f956c571b55090be985a31bb0', 'The morning was bright and fine, and the eastern sky glowed pink, and
was fretted with little golden clouds. In the road that runs from the
top of Putney Hill to Wimbledon was a number of poor vestiges of the
panic torrent that must have poured Londonward on the Sunday night
after the fighting began. There was a little two-wheeled cart inscribed
with the name of Thomas Lobb, Greengrocer, New Malden, with a smashed
wheel and an abandoned tin trunk; there was a straw hat trampled into
the now hardened mud, and at the top of West Hill a lot of
blood-stained glass about the overturned water trough. My movements
were languid, my plans of the vaguest. I had an idea of going to
Leatherhead, though I knew that there I had the poorest chance of
finding my wife. Certainly, unless death had overtaken them suddenly,
my cousins and she would have fled thence; but it seemed to me I might
find or learn there whither the Surrey people had fled. I knew I wanted
to find my wife, that my heart ached for her and the world of men, but
I had no clear idea how the finding might be done. I was also sharply
aware now of my intense loneliness. From the corner I went, under cover
of a thicket of trees and bushes, to the edge of Wimbledon Common,
stretching wide and far.', 799, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('282e41ed8f1df1821eacc6a24f404e8fadc6bf6a100b2e7895017ccda4583401', 'That dark expanse was lit in patches by yellow gorse and broom; there
was no red weed to be seen, and as I prowled, hesitating, on the verge
of the open, the sun rose, flooding it all with light and vitality. I
came upon a busy swarm of little frogs in a swampy place among the
trees. I stopped to look at them, drawing a lesson from their stout
resolve to live. And presently, turning suddenly, with an odd feeling
of being watched, I beheld something crouching amid a clump of bushes.
I stood regarding this. I made a step towards it, and it rose up and
became a man armed with a cutlass. I approached him slowly. He stood
silent and motionless, regarding me.', 800, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('39e531d663968bc2a2b8768537315bf97b1f09d517577e9b1628d6f108e8a02a', '“Stop!” he cried, when I was within ten yards of him, and I stopped.
His voice was hoarse. “Where do you come from?” he said.', 802, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5a2e6cd0dc1e5b2435fa1702d27bbc586a4bfb1c06862d1b98b24dd8d0589a53', '“Good luck!” he said. “We are lucky ones! Fancy _you_!” He put out a
hand, and I took it. “I crawled up a drain,” he said. “But they didn’t
kill everyone. And after they went away I got off towards Walton across
the fields. But—— It’s not sixteen days altogether—and your hair is
grey.” He looked over his shoulder suddenly. “Only a rook,” he said.
“One gets to know that birds have shadows these days. This is a bit
open. Let us crawl under those bushes and talk.”', 814, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2d6c8cdde98b55fc2afd335b2b6e65a040f074e83913e698a56b26407c1a60f5', '“Have you seen any Martians?” I said. “Since I crawled out——”', 815, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8e4db6d996e2e4ba151203b1101c2f5893ecd0c4c04f41c8e5b11179644d42ef', '“They’ve gone away across London,” he said. “I guess they’ve got a
bigger camp there. Of a night, all over there, Hampstead way, the sky
is alive with their lights. It’s like a great city, and in the glare
you can just see them moving. By daylight you can’t. But nearer—I
haven’t seen them—” (he counted on his fingers) “five days. Then I saw
a couple across Hammersmith way carrying something big. And the night
before last”—he stopped and spoke impressively—“it was just a matter of
lights, but it was something up in the air. I believe they’ve built a
flying-machine, and are learning to fly.”', 816, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('19b95bf2290458dbfb7ef7ef162d89fa3a8ad43b32e575f40ebac63fb74de31b', 'I stopped, on hands and knees, for we had come to the bushes.', 817, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e8a6a44ab0f879c1235af66bb9c930a029b26fc3d38d1d1b16d761a156f8baf', '“Fly!”', 818, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6c61e0a605465eee03a0a44ecc43c020af55d5f20ab1cdc79bbe62fd2c4b578f', '“Yes,” he said, “fly.”', 819, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dd46caffd071b228a29b39c8394c00d8ac1eb55629a09352d8a938dc238e8d6e', 'I went on into a little bower, and sat down.', 820, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9f8eca626073490c2f4609204672cee1312ddd93c94dd6433e0fbe3f1ef884c1', '“It is all over with humanity,” I said. “If they can do that they will
simply go round the world.”', 821, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('76f7c6b9d67fddbadcd043805cb1717da8f9ddf9c5fb10afe8bb557c61412f55', 'He nodded.', 822, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ac5cfbc0041e2ca3c24f239659a866613924395f1082bc89a61490052dd26181', '“They will. But—— It will relieve things over here a bit. And
besides——” He looked at me. “Aren’t you satisfied it _is_ up with
humanity? I am. We’re down; we’re beat.”', 823, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2cc42ab0dde2144781e2213e315017158b2fa03e23ac8980c8fe8c5869bf2c37', 'I stared. Strange as it may seem, I had not arrived at this fact—a fact
perfectly obvious so soon as he spoke. I had still held a vague hope;
rather, I had kept a lifelong habit of mind. He repeated his words,
“We’re beat.” They carried absolute conviction.', 824, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4d08d27c214e831d32fc81f4ce95a8cb8d783e779ee586ad9ae9252285f55e1d', '“It’s all over,” he said. “They’ve lost _one_—just _one_. And they’ve
made their footing good and crippled the greatest power in the world.
They’ve walked over us. The death of that one at Weybridge was an
accident. And these are only pioneers. They kept on coming. These green
stars—I’ve seen none these five or six days, but I’ve no doubt they’re
falling somewhere every night. Nothing’s to be done. We’re under! We’re
beat!”', 825, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('338ad6e49119e12834d671e0e4e981ecf5b502dd8f15209f553bd4973807576b', 'I made him no answer. I sat staring before me, trying in vain to devise
some countervailing thought.', 826, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('875906eb024e5066d4f51ebc6d8fc1a5bf721056224cad3de4780d3c5c0e6851', '“This isn’t a war,” said the artilleryman. “It never was a war, any
more than there’s war between man and ants.”', 827, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6018761ef5c826111db1d56e21a2518217b5236afb8c43c345e02006ec863ba0', 'Suddenly I recalled the night in the observatory.', 828, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7c0a0dfeee76af9ab44ef6b5fc2a44aceb212803d72ea2fa82e79589b3fd5ca5', '“After the tenth shot they fired no more—at least, until the first
cylinder came.”', 829, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bf14cd8fbeb10361986d5b118ccf84f6afef58c2e52d6ad550411d02dcaaf87a', '“How do you know?” said the artilleryman. I explained. He thought.
“Something wrong with the gun,” he said. “But what if there is? They’ll
get it right again. And even if there’s a delay, how can it alter the
end? It’s just men and ants. There’s the ants builds their cities, live
their lives, have wars, revolutions, until the men want them out of the
way, and then they go out of the way. That’s what we are now—just ants.
Only——”', 830, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('682fff5fa083f516f2d819978965f0a64a835636c1c088043b15929a3017e429', '“Yes,” I said.', 831, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('23b32328f6b2af559ef7594cf85fb77c7e79e7deb39dc093219dce78b34fbd05', '“We’re eatable ants.”', 832, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ad29778226faa6067a09de51f724ec677624e0120620da6f45fde7d3c591cd5e', 'We sat looking at each other.', 833, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d176688c8fb42a98c863b2505582ac39d166676ff6d6a36050f781aa6975bcfa', '“And what will they do with us?” I said.', 834, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a21b9ea26b87a4bbf70195f2b1ac7be5b35c8a6f2ddeb39236c25144139189a4', '“That’s what I’ve been thinking,” he said; “that’s what I’ve been
thinking. After Weybridge I went south—thinking. I saw what was up.
Most of the people were hard at it squealing and exciting themselves.
But I’m not so fond of squealing. I’ve been in sight of death once or
twice; I’m not an ornamental soldier, and at the best and worst,
death—it’s just death. And it’s the man that keeps on thinking comes
through. I saw everyone tracking away south. Says I, ‘Food won’t last
this way,’ and I turned right back. I went for the Martians like a
sparrow goes for man. All round”—he waved a hand to the
horizon—“they’re starving in heaps, bolting, treading on each other. .
. .”', 835, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8184ca2d3b702a61d2d86ee32aa529791ba325318b98cbdff3e2e8f87824cf8c', 'He saw my face, and halted awkwardly.', 836, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('631d1638444f7bc80ee94a54a467fc8c77c6c9d8b5f7c72580d4d0eb74cb9ced', '“No doubt lots who had money have gone away to France,” he said. He
seemed to hesitate whether to apologise, met my eyes, and went on:
“There’s food all about here. Canned things in shops; wines, spirits,
mineral waters; and the water mains and drains are empty. Well, I was
telling you what I was thinking. ‘Here’s intelligent things,’ I said,
‘and it seems they want us for food. First, they’ll smash us up—ships,
machines, guns, cities, all the order and organisation. All that will
go. If we were the size of ants we might pull through. But we’re not.
It’s all too bulky to stop. That’s the first certainty.’ Eh?”', 837, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d3b8c9b1ded4cfd3aa12d0350f8ae6bafe46e1a697c58a21cba0c9d771a95099', 'I assented.', 838, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a36dad83701c52c997abf3a627a0f3188423cf83cb221d8ececdd6b630c359c3', '“It is; I’ve thought it out. Very well, then—next; at present we’re
caught as we’re wanted. A Martian has only to go a few miles to get a
crowd on the run. And I saw one, one day, out by Wandsworth, picking
houses to pieces and routing among the wreckage. But they won’t keep on
doing that. So soon as they’ve settled all our guns and ships, and
smashed our railways, and done all the things they are doing over
there, they will begin catching us systematic, picking the best and
storing us in cages and things. That’s what they will start doing in a
bit. Lord! They haven’t begun on us yet. Don’t you see that?”', 839, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('237a3e14ac73b80a22eb25325242b3cb5d60c28fe77670a06672f5cc22727639', '“Not begun!” I exclaimed.', 840, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('735dc1a0e173aa7d211aa2f40c86b2ecdc67fc07ab3e7ad1dd033a870d2e3537', '“Not begun. All that’s happened so far is through our not having the
sense to keep quiet—worrying them with guns and such foolery. And
losing our heads, and rushing off in crowds to where there wasn’t any
more safety than where we were. They don’t want to bother us yet.
They’re making their things—making all the things they couldn’t bring
with them, getting things ready for the rest of their people. Very
likely that’s why the cylinders have stopped for a bit, for fear of
hitting those who are here. And instead of our rushing about blind, on
the howl, or getting dynamite on the chance of busting them up, we’ve
got to fix ourselves up according to the new state of affairs. That’s
how I figure it out. It isn’t quite according to what a man wants for
his species, but it’s about what the facts point to. And that’s the
principle I acted upon. Cities, nations, civilisation, progress—it’s
all over. That game’s up. We’re beat.”', 841, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0bee4245666c3eb5f50488f3c85c666e7419352b63dbb831fcb03518f8dc16b8', '“But if that is so, what is there to live for?”', 842, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('83a5bd6b4116080c24b84b2a1bd6c29955d132ec671ad0210809fe4d090e4717', 'The artilleryman looked at me for a moment.', 843, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f02251ef6dddc44b61c3de164423d872b0379de45853d21465fedafe26032db3', '“There won’t be any more blessed concerts for a million years or so;
there won’t be any Royal Academy of Arts, and no nice little feeds at
restaurants. If it’s amusement you’re after, I reckon the game is up.
If you’ve got any drawing-room manners or a dislike to eating peas with
a knife or dropping aitches, you’d better chuck ’em away. They ain’t no
further use.”', 844, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7c9f13ad7897f17007dfe1c0abb80c2fc27352d4a6b033f251e0473530ee89fd', '“You mean——”', 845, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4891f356bd250069ca9e8c81357c261539a9fa8e904a9200a92d6629a88caf1c', '“I mean that men like me are going on living—for the sake of the breed.
I tell you, I’m grim set on living. And if I’m not mistaken, you’ll
show what insides _you’ve_ got, too, before long. We aren’t going to be
exterminated. And I don’t mean to be caught either, and tamed and
fattened and bred like a thundering ox. Ugh! Fancy those brown
creepers!”', 846, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2fb37b4efa9110aca04caf2f6b756036cd067bc8a2ce2bf6269b2dbcd4c25423', '“You don’t mean to say——”', 847, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('af448cc3579f17a7e948e1ac8d249e0df6690a421fe83bca2d95ad4604211518', '“I do. I’m going on, under their feet. I’ve got it planned; I’ve
thought it out. We men are beat. We don’t know enough. We’ve got to
learn before we’ve got a chance. And we’ve got to live and keep
independent while we learn. See! That’s what has to be done.”', 848, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('54441c7761f9769a27770eb5e6e2c5e35853fe2645d6a59a1a3b757789f1575f', 'I stared, astonished, and stirred profoundly by the man’s resolution.', 849, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e4dc5a9257013bfa45e81271d58e9811dbffafa5fa028e7efeb8870850af30eb', '“Great God!” cried I. “But you are a man indeed!” And suddenly I
gripped his hand.', 850, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('15b4191e0d0cd585f639a83180cfbc044878d033dc4dade44fee610359ab749c', '“Eh!” he said, with his eyes shining. “I’ve thought it out, eh?”', 851, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('745a8a5f12e47d09658a8a91b8637e664c64c25c84e6b5ac43b006ee5c53eb61', '“Go on,” I said.', 852, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ff1f29d38a7dc95a188c652585f639fee558b72677a85282fee2c3014a63d5a6', '“Well, those who mean to escape their catching must get ready. I’m
getting ready. Mind you, it isn’t all of us that are made for wild
beasts; and that’s what it’s got to be. That’s why I watched you. I had
my doubts. You’re slender. I didn’t know that it was you, you see, or
just how you’d been buried. All these—the sort of people that lived in
these houses, and all those damn little clerks that used to live down
_that_ way—they’d be no good. They haven’t any spirit in them—no proud
dreams and no proud lusts; and a man who hasn’t one or the other—Lord!
What is he but funk and precautions? They just used to skedaddle off to
work—I’ve seen hundreds of ’em, bit of breakfast in hand, running wild
and shining to catch their little season-ticket train, for fear they’d
get dismissed if they didn’t; working at businesses they were afraid to
take the trouble to understand; skedaddling back for fear they wouldn’t
be in time for dinner; keeping indoors after dinner for fear of the
back streets, and sleeping with the wives they married, not because
they wanted them, but because they had a bit of money that would make
for safety in their one little miserable skedaddle through the world.
Lives insured and a bit invested for fear of accidents. And on
Sundays—fear of the hereafter. As if hell was built for rabbits! Well,
the Martians will just be a godsend to these. Nice roomy cages,
fattening food, careful breeding, no worry. After a week or so chasing
about the fields and lands on empty stomachs, they’ll come and be
caught cheerful. They’ll be quite glad after a bit. They’ll wonder what
people did before there were Martians to take care of them. And the bar
loafers, and mashers, and singers—I can imagine them. I can imagine
them,” he said, with a sort of sombre gratification. “There’ll be any
amount of sentiment and religion loose among them. There’s hundreds of
things I saw with my eyes that I’ve only begun to see clearly these
last few days. There’s lots will take things as they are—fat and
stupid; and lots will be worried by a sort of feeling that it’s all
wrong, and that they ought to be doing something. Now whenever things
are so that a lot of people feel they ought to be doing something, the
weak, and those who go weak with a lot of complicated thinking, always
make for a sort of do-nothing religion, very pious and superior, and
submit to persecution and the will of the Lord. Very likely you’ve seen
the same thing. It’s energy in a gale of funk, and turned clean inside
out. These cages will be full of psalms and hymns and piety. And those
of a less simple sort will work in a bit of—what is it?—eroticism.”', 853, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ed7f679cdfe339bde82898da726a2662e70b279e9ab91add99e545fdd102dbe6', 'He paused.', 854, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1af19028ee2ddcabf259f4315e829794c55fda92e93e9f24301936a064c09d10', '“Very likely these Martians will make pets of some of them; train them
to do tricks—who knows?—get sentimental over the pet boy who grew up
and had to be killed. And some, maybe, they will train to hunt us.”', 855, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('91e1eb4a9dbbcf32cdf70dd61f5364aaff76a383594937a93a540f282cf5e5ce', '“No,” I cried, “that’s impossible! No human being——”', 856, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('771084fca6a4f9a9f2dfa88958ce9697030d83c9dc490f953e6b9ec04c526af0', '“What’s the good of going on with such lies?” said the artilleryman.
“There’s men who’d do it cheerful. What nonsense to pretend there
isn’t!”', 857, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('973708ffd1596a8c5bcfe612148cc4300a9bde58166e9658f48498c0c2d0d8ab', 'And I succumbed to his conviction.', 858, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8b2790486f75ffa752cfa7673361fd8607344e174e003403a5677965af958786', '“If they come after me,” he said; “Lord, if they come after me!” and
subsided into a grim meditation.', 859, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('da3b26c44d63f81ac408a20c8d0a5de157ec725c4ec7466b6cfa3af929480b33', 'I sat contemplating these things. I could find nothing to bring against
this man’s reasoning. In the days before the invasion no one would have
questioned my intellectual superiority to his—I, a professed and
recognised writer on philosophical themes, and he, a common soldier;
and yet he had already formulated a situation that I had scarcely
realised.', 860, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fd9cb0dda63e62f858bfe14f1f5b889b8328b06f01489cd54174e9a77957c649', '“What are you doing?” I said presently. “What plans have you made?”', 861, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dcc99cbab327797ac72508103cd232a5e94ada2cd2571cbe3f2842c52f2dad6e', 'He hesitated.', 862, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d57db680fd096eb22498a7abbfe20529bc73aee45c0816d1888c055151fe6690', '“Well, it’s like this,” he said. “What have we to do? We have to invent
a sort of life where men can live and breed, and be sufficiently secure
to bring the children up. Yes—wait a bit, and I’ll make it clearer what
I think ought to be done. The tame ones will go like all tame beasts;
in a few generations they’ll be big, beautiful, rich-blooded,
stupid—rubbish! The risk is that we who keep wild will go
savage—degenerate into a sort of big, savage rat. . . . You see, how I
mean to live is underground. I’ve been thinking about the drains. Of
course those who don’t know drains think horrible things; but under
this London are miles and miles—hundreds of miles—and a few days rain
and London empty will leave them sweet and clean. The main drains are
big enough and airy enough for anyone. Then there’s cellars, vaults,
stores, from which bolting passages may be made to the drains. And the
railway tunnels and subways. Eh? You begin to see? And we form a
band—able-bodied, clean-minded men. We’re not going to pick up any
rubbish that drifts in. Weaklings go out again.”', 863, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('afa358a0542370ac9b08cb0d8ecbe16c2071036d863c2c493402577ef0207f73', '“As you meant me to go?”', 864, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b791bc5d7429ba378174b9f5de25935f4d6edf0b271656a999c6009bddcad1d2', '“Well—I parleyed, didn’t I?”', 865, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eaac82cc8f67d02e88960eee23303ff81b4f6447d70679321e528b433cc332bb', '“We won’t quarrel about that. Go on.”', 866, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4cca762a805effac7ed75299f532d8f03d8ad94e5162b943b446fc483c09b5e5', '“Those who stop obey orders. Able-bodied, clean-minded women we want
also—mothers and teachers. No lackadaisical ladies—no blasted rolling
eyes. We can’t have any weak or silly. Life is real again, and the
useless and cumbersome and mischievous have to die. They ought to die.
They ought to be willing to die. It’s a sort of disloyalty, after all,
to live and taint the race. And they can’t be happy. Moreover, dying’s
none so dreadful; it’s the funking makes it bad. And in all those
places we shall gather. Our district will be London. And we may even be
able to keep a watch, and run about in the open when the Martians keep
away. Play cricket, perhaps. That’s how we shall save the race. Eh?
It’s a possible thing? But saving the race is nothing in itself. As I
say, that’s only being rats. It’s saving our knowledge and adding to it
is the thing. There men like you come in. There’s books, there’s
models. We must make great safe places down deep, and get all the books
we can; not novels and poetry swipes, but ideas, science books. That’s
where men like you come in. We must go to the British Museum and pick
all those books through. Especially we must keep up our science—learn
more. We must watch these Martians. Some of us must go as spies. When
it’s all working, perhaps I will. Get caught, I mean. And the great
thing is, we must leave the Martians alone. We mustn’t even steal. If
we get in their way, we clear out. We must show them we mean no harm.
Yes, I know. But they’re intelligent things, and they won’t hunt us
down if they have all they want, and think we’re just harmless vermin.”', 867, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('faebcc5c7161ec8812b47834c9fd900e3fc2df12b12323c2f611e17add0a7210', 'The artilleryman paused and laid a brown hand upon my arm.', 868, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('30fd4bcf193b2991dc5232e4ea4bfeb39c92135c4d931271d8c3a09196824c8b', '“After all, it may not be so much we may have to learn before—Just
imagine this: four or five of their fighting machines suddenly starting
off—Heat-Rays right and left, and not a Martian in ’em. Not a Martian
in ’em, but men—men who have learned the way how. It may be in my time,
even—those men. Fancy having one of them lovely things, with its
Heat-Ray wide and free! Fancy having it in control! What would it
matter if you smashed to smithereens at the end of the run, after a
bust like that? I reckon the Martians’ll open their beautiful eyes!
Can’t you see them, man? Can’t you see them hurrying, hurrying—puffing
and blowing and hooting to their other mechanical affairs? Something
out of gear in every case. And swish, bang, rattle, swish! Just as they
are fumbling over it, _swish_ comes the Heat-Ray, and, behold! man has
come back to his own.”', 869, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e45b98608cb9b5887d192017a8737a894cf8f60222cab5fa9f05ff7460bc4827', 'For a while the imaginative daring of the artilleryman, and the tone of
assurance and courage he assumed, completely dominated my mind. I
believed unhesitatingly both in his forecast of human destiny and in
the practicability of his astonishing scheme, and the reader who thinks
me susceptible and foolish must contrast his position, reading steadily
with all his thoughts about his subject, and mine, crouching fearfully
in the bushes and listening, distracted by apprehension. We talked in
this manner through the early morning time, and later crept out of the
bushes, and, after scanning the sky for Martians, hurried precipitately
to the house on Putney Hill where he had made his lair. It was the coal
cellar of the place, and when I saw the work he had spent a week
upon—it was a burrow scarcely ten yards long, which he designed to
reach to the main drain on Putney Hill—I had my first inkling of the
gulf between his dreams and his powers. Such a hole I could have dug in
a day. But I believed in him sufficiently to work with him all that
morning until past midday at his digging. We had a garden barrow and
shot the earth we removed against the kitchen range. We refreshed
ourselves with a tin of mock-turtle soup and wine from the neighbouring
pantry. I found a curious relief from the aching strangeness of the
world in this steady labour. As we worked, I turned his project over in
my mind, and presently objections and doubts began to arise; but I
worked there all the morning, so glad was I to find myself with a
purpose again. After working an hour I began to speculate on the
distance one had to go before the cloaca was reached, the chances we
had of missing it altogether. My immediate trouble was why we should
dig this long tunnel, when it was possible to get into the drain at
once down one of the manholes, and work back to the house. It seemed to
me, too, that the house was inconveniently chosen, and required a
needless length of tunnel. And just as I was beginning to face these
things, the artilleryman stopped digging, and looked at me.', 870, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('248a708befb187bc40625b7b29afcdd9dcccde59030f1dba1c3ad14ab3c70166', '“We’re working well,” he said. He put down his spade. “Let us knock off
a bit” he said. “I think it’s time we reconnoitred from the roof of the
house.”', 871, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0a22a65141272e8896e36d811e6bc91d744a39d5f53f8cc3c21b498c146a9f61', 'I was for going on, and after a little hesitation he resumed his spade;
and then suddenly I was struck by a thought. I stopped, and so did he
at once.', 872, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('461b50c3b3d3251e7d52f527593be6edc7666bf77aeb89cf0e570535988f3c2e', '“Why were you walking about the common,” I said, “instead of being
here?”', 873, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('105cd94df60cb4677f70e7ac2e0d0e38826224b49be3397b970bc6456410606b', '“Taking the air,” he said. “I was coming back. It’s safer by night.”', 874, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ba5d27e85466df1b8d6ba2512a22fccd48aa280d9d7cdcd9319e72e0ab10ada5', '“But the work?”', 875, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8d73abe45e3bb1cbd2ce301b5026707de6a807d0290d76c35c29c946167467b2', 'A Norwegian dataset consisting of 400 well reports (58,000 pages) and an Australian well database
consisting of 6,000 pages have been used as training data for generating structured data.', 18, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('24d6c04a22fc42c03ec9b810044772177cb5303c20edc151556064b74a5828e0', '“Oh, one can’t always work,” he said, and in a flash I saw the man
plain. He hesitated, holding his spade. “We ought to reconnoitre now,”
he said, “because if any come near they may hear the spades and drop
upon us unawares.”', 876, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('083ff2bd3fcf84bc8a7480b0fc80f069f4efb9b7e46d5726d676092d41272df2', 'I was no longer disposed to object. We went together to the roof and
stood on a ladder peeping out of the roof door. No Martians were to be
seen, and we ventured out on the tiles, and slipped down under shelter
of the parapet.', 877, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('13da2136788c12aa5ad3af08391978c2bee2a9ed826cd251ce94e2f9b59cd47d', 'From this position a shrubbery hid the greater portion of Putney, but
we could see the river below, a bubbly mass of red weed, and the low
parts of Lambeth flooded and red. The red creeper swarmed up the trees
about the old palace, and their branches stretched gaunt and dead, and
set with shrivelled leaves, from amid its clusters. It was strange how
entirely dependent both these things were upon flowing water for their
propagation. About us neither had gained a footing; laburnums, pink
mays, snowballs, and trees of arbor-vitae, rose out of laurels and
hydrangeas, green and brilliant into the sunlight. Beyond Kensington
dense smoke was rising, and that and a blue haze hid the northward
hills.', 878, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3f6db8a86ec1a804332a5678f43304c9e1c9c77887f4a3a70c1ba21777f94c8b', 'The artilleryman began to tell me of the sort of people who still
remained in London.', 879, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('261b764724cc568508e59160a4be2ce13448d83593453a79d49ede2b17cf6265', '“One night last week,” he said, “some fools got the electric light in
order, and there was all Regent Street and the Circus ablaze, crowded
with painted and ragged drunkards, men and women, dancing and shouting
till dawn. A man who was there told me. And as the day came they became
aware of a fighting-machine standing near by the Langham and looking
down at them. Heaven knows how long he had been there. It must have
given some of them a nasty turn. He came down the road towards them,
and picked up nearly a hundred too drunk or frightened to run away.”', 880, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('95a705420162f501e3f79c69669454862f9fc90c7d5da14c198431a4cd9a4d18', 'Grotesque gleam of a time no history will ever fully describe!', 881, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('46ce5af6af9a1a20feed70d3934aac8aa41e006d775d7525dd9487f6e9cdee92', 'From that, in answer to my questions, he came round to his grandiose
plans again. He grew enthusiastic. He talked so eloquently of the
possibility of capturing a fighting-machine that I more than half
believed in him again. But now that I was beginning to understand
something of his quality, I could divine the stress he laid on doing
nothing precipitately. And I noted that now there was no question that
he personally was to capture and fight the great machine.', 882, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cb74256e4cdb161aa41730aa4655a749e75890e7645b81e30147f57a3bf767c1', 'After a time we went down to the cellar. Neither of us seemed disposed
to resume digging, and when he suggested a meal, I was nothing loath.
He became suddenly very generous, and when we had eaten he went away
and returned with some excellent cigars. We lit these, and his optimism
glowed. He was inclined to regard my coming as a great occasion.', 883, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e67bd70cd435a6c44fc2e14b624d114ca8d061fe52c4fe856d015e7540ed5e79', '“There’s some champagne in the cellar,” he said.', 884, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('31ea7ab70196595acd849dcab5991cf5c5bab042492a436626757d39e5336f0a', '“We can dig better on this Thames-side burgundy,” said I.', 885, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4f29cc0e61348f75d06a1f962614d220f082d9cbe59bfc2d491d490548cc0657', '“No,” said he; “I am host today. Champagne! Great God! We’ve a heavy
enough task before us! Let us take a rest and gather strength while we
may. Look at these blistered hands!”', 886, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4178dc269ac709cdb861fe9bd150d128013771b0a3a8757b989637bb4f5f417f', 'And pursuant to this idea of a holiday, he insisted upon playing cards
after we had eaten. He taught me euchre, and after dividing London
between us, I taking the northern side and he the southern, we played
for parish points. Grotesque and foolish as this will seem to the sober
reader, it is absolutely true, and what is more remarkable, I found the
card game and several others we played extremely interesting.', 887, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('88ed94a67c765a8932cbca1b96987c862005ebe393899de1436fafea20ad73de', 'Strange mind of man! that, with our species upon the edge of
extermination or appalling degradation, with no clear prospect before
us but the chance of a horrible death, we could sit following the
chance of this painted pasteboard, and playing the “joker” with vivid
delight. Afterwards he taught me poker, and I beat him at three tough
chess games. When dark came we decided to take the risk, and lit a
lamp.', 888, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0135cf187329a0422028bc5693ededdc4c2aeea4eaa1e60322943f9c3004c0ee', 'After an interminable string of games, we supped, and the artilleryman
finished the champagne. We went on smoking the cigars. He was no longer
the energetic regenerator of his species I had encountered in the
morning. He was still optimistic, but it was a less kinetic, a more
thoughtful optimism. I remember he wound up with my health, proposed in
a speech of small variety and considerable intermittence. I took a
cigar, and went upstairs to look at the lights of which he had spoken
that blazed so greenly along the Highgate hills.', 889, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a577154d036dfe62b652133cc7537689fe421812376b706d47be5f67c21b6f8e', 'At first I stared unintelligently across the London valley. The
northern hills were shrouded in darkness; the fires near Kensington
glowed redly, and now and then an orange-red tongue of flame flashed up
and vanished in the deep blue night. All the rest of London was black.
Then, nearer, I perceived a strange light, a pale, violet-purple
fluorescent glow, quivering under the night breeze. For a space I could
not understand it, and then I knew that it must be the red weed from
which this faint irradiation proceeded. With that realisation my
dormant sense of wonder, my sense of the proportion of things, awoke
again. I glanced from that to Mars, red and clear, glowing high in the
west, and then gazed long and earnestly at the darkness of Hampstead
and Highgate.', 890, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('7401d27fe2ee16c0bb5f606f0bb1f294228e6351caefb15b734106dac07c0417', '
And now comes the strangest thing in my story. Yet, perhaps, it is not
altogether strange. I remember, clearly and coldly and vividly, all
that I did that day until the time that I stood weeping and praising
God upon the summit of Primrose Hill. And then I forget.', 927, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d3d374aa822efeac7b6f2032db68ee47e8c0dbc6f5bacaa24d033f7f1fb50060', 'I remained a very long time upon the roof, wondering at the grotesque
changes of the day. I recalled my mental states from the midnight
prayer to the foolish card-playing. I had a violent revulsion of
feeling. I remember I flung away the cigar with a certain wasteful
symbolism. My folly came to me with glaring exaggeration. I seemed a
traitor to my wife and to my kind; I was filled with remorse. I
resolved to leave this strange undisciplined dreamer of great things to
his drink and gluttony, and to go on into London. There, it seemed to
me, I had the best chance of learning what the Martians and my
fellowmen were doing. I was still upon the roof when the late moon
rose.', 891, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a1b24cebd7762581213e0e2ca936afef216cdd504fab1ddd167b98402cf48050', '', 892, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3bdadf76ddae42f04a569b9af5669f857aa9d6fdb78f1fa86f6d33f0f7ad8721', '
VIII.
DEAD LONDON.', 893, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('39d89eeddadef8b32ccf90617f94e60f2723efc8014445ce243d4e700a24eeb6', '
After I had parted from the artilleryman, I went down the hill, and by
the High Street across the bridge to Fulham. The red weed was
tumultuous at that time, and nearly choked the bridge roadway; but its
fronds were already whitened in patches by the spreading disease that
presently removed it so swiftly.', 894, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8dfb61a28a54c52f2235d91b39e0c5ef40f96fde39e3557ed5d8a0bff00d4b95', 'At the corner of the lane that runs to Putney Bridge station I found a
man lying. He was as black as a sweep with the black dust, alive, but
helplessly and speechlessly drunk. I could get nothing from him but
curses and furious lunges at my head. I think I should have stayed by
him but for the brutal expression of his face.', 895, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('20c29e3e0c50961a02ba8629e00598a624184214af18a16390b6d0d0fafe280a', 'There was black dust along the roadway from the bridge onwards, and it
grew thicker in Fulham. The streets were horribly quiet. I got
food—sour, hard, and mouldy, but quite eatable—in a baker’s shop here.
Some way towards Walham Green the streets became clear of powder, and I
passed a white terrace of houses on fire; the noise of the burning was
an absolute relief. Going on towards Brompton, the streets were quiet
again.', 896, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8b87447e416bf2f7643d7dbcc7ef375f0dc751182bae6801cf796685738a4c14', 'Here I came once more upon the black powder in the streets and upon
dead bodies. I saw altogether about a dozen in the length of the Fulham
Road. They had been dead many days, so that I hurried quickly past
them. The black powder covered them over, and softened their outlines.
One or two had been disturbed by dogs.', 897, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fd72b6b6732f00f7709c7ba21ba95a7cc90d44d37eba9a7ba36c2fc880c75c10', 'Where there was no black powder, it was curiously like a Sunday in the
City, with the closed shops, the houses locked up and the blinds drawn,
the desertion, and the stillness. In some places plunderers had been at
work, but rarely at other than the provision and wine shops. A
jeweller’s window had been broken open in one place, but apparently the
thief had been disturbed, and a number of gold chains and a watch lay
scattered on the pavement. I did not trouble to touch them. Farther on
was a tattered woman in a heap on a doorstep; the hand that hung over
her knee was gashed and bled down her rusty brown dress, and a smashed
magnum of champagne formed a pool across the pavement. She seemed
asleep, but she was dead.', 898, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6eee82662b3eeaf8df79ad0e99946b4cdff05d16a24797dd1e17902844db878c', 'The farther I penetrated into London, the profounder grew the
stillness. But it was not so much the stillness of death—it was the
stillness of suspense, of expectation. At any time the destruction that
had already singed the northwestern borders of the metropolis, and had
annihilated Ealing and Kilburn, might strike among these houses and
leave them smoking ruins. It was a city condemned and derelict. . . .', 899, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('58023be96052010e878bb709adcd765f3f951cc6a2647207a1fe49e3ca88b1e9', 'In South Kensington the streets were clear of dead and of black powder.
It was near South Kensington that I first heard the howling. It crept
almost imperceptibly upon my senses. It was a sobbing alternation of
two notes, “Ulla, ulla, ulla, ulla,” keeping on perpetually. When I
passed streets that ran northward it grew in volume, and houses and
buildings seemed to deaden and cut it off again. It came in a full tide
down Exhibition Road. I stopped, staring towards Kensington Gardens,
wondering at this strange, remote wailing. It was as if that mighty
desert of houses had found a voice for its fear and solitude.', 900, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('54f953ed3e4077b2928d72c6aec1aacbdbf2df24abefad2fb85f6f7fb6991f13', '“Ulla, ulla, ulla, ulla,” wailed that superhuman note—great waves of
sound sweeping down the broad, sunlit roadway, between the tall
buildings on each side. I turned northwards, marvelling, towards the
iron gates of Hyde Park. I had half a mind to break into the Natural
History Museum and find my way up to the summits of the towers, in
order to see across the park. But I decided to keep to the ground,
where quick hiding was possible, and so went on up the Exhibition Road.
All the large mansions on each side of the road were empty and still,
and my footsteps echoed against the sides of the houses. At the top,
near the park gate, I came upon a strange sight—a bus overturned, and
the skeleton of a horse picked clean. I puzzled over this for a time,
and then went on to the bridge over the Serpentine. The voice grew
stronger and stronger, though I could see nothing above the housetops
on the north side of the park, save a haze of smoke to the northwest.', 901, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('160b502c268be86753d6fe266dbb2ed52638110c548a91bde1c4edf0c7cb7810', '“Ulla, ulla, ulla, ulla,” cried the voice, coming, as it seemed to me,
from the district about Regent’s Park. The desolating cry worked upon
my mind. The mood that had sustained me passed. The wailing took
possession of me. I found I was intensely weary, footsore, and now
again hungry and thirsty.', 902, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('738ab919f0c40e8c2cffb78ce0c5276fab0b209aeaf360afab132161ae99971f', 'It was already past noon. Why was I wandering alone in this city of the
dead? Why was I alone when all London was lying in state, and in its
black shroud? I felt intolerably lonely. My mind ran on old friends
that I had forgotten for years. I thought of the poisons in the
chemists’ shops, of the liquors the wine merchants stored; I recalled
the two sodden creatures of despair, who so far as I knew, shared the
city with myself. . . .', 903, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('16fbf720b4d1e3c7d0c7f03a3a1b04b8cf7b1ba05ee755db5487a3e62dd76cf8', 'Of the next three days I know nothing. I have learned since that, so
far from my being the first discoverer of the Martian overthrow,
several such wanderers as myself had already discovered this on the
previous night. One man—the first—had gone to St. Martin’s-le-Grand,
and, while I sheltered in the cabmen’s hut, had contrived to telegraph
to Paris. Thence the joyful news had flashed all over the world; a
thousand cities, chilled by ghastly apprehensions, suddenly flashed
into frantic illuminations; they knew of it in Dublin, Edinburgh,
Manchester, Birmingham, at the time when I stood upon the verge of the
pit. Already men, weeping with joy, as I have heard, shouting and
staying their work to shake hands and shout, were making up trains,
even as near as Crewe, to descend upon London. The church bells that
had ceased a fortnight since suddenly caught the news, until all
England was bell-ringing. Men on cycles, lean-faced, unkempt, scorched
along every country lane shouting of unhoped deliverance, shouting to
gaunt, staring figures of despair. And for the food! Across the
Channel, across the Irish Sea, across the Atlantic, corn, bread, and
meat were tearing to our relief. All the shipping in the world seemed
going Londonward in those days. But of all this I have no memory. I
drifted—a demented man. I found myself in a house of kindly people, who
had found me on the third day wandering, weeping, and raving through
the streets of St. John’s Wood. They have told me since that I was
singing some insane doggerel about “The Last Man Left Alive! Hurrah!
The Last Man Left Alive!” Troubled as they were with their own affairs,
these people, whose name, much as I would like to express my gratitude
to them, I may not even give here, nevertheless cumbered themselves
with me, sheltered me, and protected me from myself. Apparently they
had learned something of my story from me during the days of my lapse.', 928, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1262dc28247bb9e0192f191963f3281c796f9d4ca8c7fbc2cb2b805fed7f69e7', 'I came into Oxford Street by the Marble Arch, and here again were black
powder and several bodies, and an evil, ominous smell from the gratings
of the cellars of some of the houses. I grew very thirsty after the
heat of my long walk. With infinite trouble I managed to break into a
public-house and get food and drink. I was weary after eating, and went
into the parlour behind the bar, and slept on a black horsehair sofa I
found there.', 904, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8b7030679986d71b49119f273b863d1c545779c2023a4a01c97b9e940b409cb2', 'I awoke to find that dismal howling still in my ears, “Ulla, ulla,
ulla, ulla.” It was now dusk, and after I had routed out some biscuits
and a cheese in the bar—there was a meat safe, but it contained nothing
but maggots—I wandered on through the silent residential squares to
Baker Street—Portman Square is the only one I can name—and so came out
at last upon Regent’s Park. And as I emerged from the top of Baker
Street, I saw far away over the trees in the clearness of the sunset
the hood of the Martian giant from which this howling proceeded. I was
not terrified. I came upon him as if it were a matter of course. I
watched him for some time, but he did not move. He appeared to be
standing and yelling, for no reason that I could discover.', 905, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('24d189eeb10b50dfa4a700430c1343a9f2158faac497da74a1407f1ebd0e7611', 'I tried to formulate a plan of action. That perpetual sound of “Ulla,
ulla, ulla, ulla,” confused my mind. Perhaps I was too tired to be very
fearful. Certainly I was more curious to know the reason of this
monotonous crying than afraid. I turned back away from the park and
struck into Park Road, intending to skirt the park, went along under
the shelter of the terraces, and got a view of this stationary, howling
Martian from the direction of St. John’s Wood. A couple of hundred
yards out of Baker Street I heard a yelping chorus, and saw, first a
dog with a piece of putrescent red meat in his jaws coming headlong
towards me, and then a pack of starving mongrels in pursuit of him. He
made a wide curve to avoid me, as though he feared I might prove a
fresh competitor. As the yelping died away down the silent road, the
wailing sound of “Ulla, ulla, ulla, ulla,” reasserted itself.', 906, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ae6c087f95ffa08aa865a378b3eea90ab756ced816e00a2d1894a1bae906ebe3', 'I came upon the wrecked handling-machine halfway to St. John’s Wood
station. At first I thought a house had fallen across the road. It was
only as I clambered among the ruins that I saw, with a start, this
mechanical Samson lying, with its tentacles bent and smashed and
twisted, among the ruins it had made. The forepart was shattered. It
seemed as if it had driven blindly straight at the house, and had been
overwhelmed in its overthrow. It seemed to me then that this might have
happened by a handling-machine escaping from the guidance of its
Martian. I could not clamber among the ruins to see it, and the
twilight was now so far advanced that the blood with which its seat was
smeared, and the gnawed gristle of the Martian that the dogs had left,
were invisible to me.', 907, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('575f8b991d4b0aa105d65004385f4a10104c9443c0bf963c77cb4a0b44569e89', 'Wondering still more at all that I had seen, I pushed on towards
Primrose Hill. Far away, through a gap in the trees, I saw a second
Martian, as motionless as the first, standing in the park towards the
Zoological Gardens, and silent. A little beyond the ruins about the
smashed handling-machine I came upon the red weed again, and found the
Regent’s Canal, a spongy mass of dark-red vegetation.', 908, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5d7fc30de743e73cd0d48bc48e092439cdee7efadaaa16142c03174a6d4a7b46', 'As I crossed the bridge, the sound of “Ulla, ulla, ulla, ulla,” ceased.
It was, as it were, cut off. The silence came like a thunderclap.', 909, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('35372b698c2d89498250659cd4a8f7c5c080d7c9e40a1916e0648722e277f0a3', 'The dusky houses about me stood faint and tall and dim; the trees
towards the park were growing black. All about me the red weed
clambered among the ruins, writhing to get above me in the dimness.
Night, the mother of fear and mystery, was coming upon me. But while
that voice sounded the solitude, the desolation, had been endurable; by
virtue of it London had still seemed alive, and the sense of life about
me had upheld me. Then suddenly a change, the passing of something—I
knew not what—and then a stillness that could be felt. Nothing but this
gaunt quiet.', 910, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('339cf2fe7a5041f1a26b1d5547487bf53000de1d2ac183bada9bc804cef4a49e', 'London about me gazed at me spectrally. The windows in the white houses
were like the eye sockets of skulls. About me my imagination found a
thousand noiseless enemies moving. Terror seized me, a horror of my
temerity. In front of me the road became pitchy black as though it was
tarred, and I saw a contorted shape lying across the pathway. I could
not bring myself to go on. I turned down St. John’s Wood Road, and ran
headlong from this unendurable stillness towards Kilburn. I hid from
the night and the silence, until long after midnight, in a cabmen’s
shelter in Harrow Road. But before the dawn my courage returned, and
while the stars were still in the sky I turned once more towards
Regent’s Park. I missed my way among the streets, and presently saw
down a long avenue, in the half-light of the early dawn, the curve of
Primrose Hill. On the summit, towering up to the fading stars, was a
third Martian, erect and motionless like the others.', 911, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('88e7537893cc03d756458cabd5f5bc6d1fcfa91e8e63de297680f57c5ad7c738', 'An insane resolve possessed me. I would die and end it. And I would
save myself even the trouble of killing myself. I marched on recklessly
towards this Titan, and then, as I drew nearer and the light grew, I
saw that a multitude of black birds was circling and clustering about
the hood. At that my heart gave a bound, and I began running along the
road.', 912, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d8ae93a3b77c9bf80c922997321d78d78fad2922d186d54d4ff7c9a4b895a214', 'I hurried through the red weed that choked St. Edmund’s Terrace (I
waded breast-high across a torrent of water that was rushing down from
the waterworks towards the Albert Road), and emerged upon the grass
before the rising of the sun. Great mounds had been heaped about the
crest of the hill, making a huge redoubt of it—it was the final and
largest place the Martians had made—and from behind these heaps there
rose a thin smoke against the sky. Against the sky line an eager dog
ran and disappeared. The thought that had flashed into my mind grew
real, grew credible. I felt no fear, only a wild, trembling exultation,
as I ran up the hill towards the motionless monster. Out of the hood
hung lank shreds of brown, at which the hungry birds pecked and tore.', 913, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f1bae1fb7323a51c7daaf5bf23cf70a27953de6b5183d7f50641e5244d7706d7', 'Introduction', 9, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('077fda465d515714389fd90d5d1f7f0aed98dc5724a1ce0195bfa5ed4e9b096c', 'In another moment I had scrambled up the earthen rampart and stood upon
its crest, and the interior of the redoubt was below me. A mighty space
it was, with gigantic machines here and there within it, huge mounds of
material and strange shelter places. And scattered about it, some in
their overturned war-machines, some in the now rigid handling-machines,
and a dozen of them stark and silent and laid in a row, were the
Martians—_dead_!—slain by the putrefactive and disease bacteria against
which their systems were unprepared; slain as the red weed was being
slain; slain, after all man’s devices had failed, by the humblest
things that God, in his wisdom, has put upon this earth.', 914, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a3e19e1bccdbdfa20ea2c9706a9b4e8b867b39ad01c436e3d9e7cabd7bbdddaf', 'For so it had come about, as indeed I and many men might have foreseen
had not terror and disaster blinded our minds. These germs of disease
have taken toll of humanity since the beginning of things—taken toll of
our prehuman ancestors since life began here. But by virtue of this
natural selection of our kind we have developed resisting power; to no
germs do we succumb without a struggle, and to many—those that cause
putrefaction in dead matter, for instance—our living frames are
altogether immune. But there are no bacteria in Mars, and directly
these invaders arrived, directly they drank and fed, our microscopic
allies began to work their overthrow. Already when I watched them they
were irrevocably doomed, dying and rotting even as they went to and
fro. It was inevitable. By the toll of a billion deaths man has bought
his birthright of the earth, and it is his against all comers; it would
still be his were the Martians ten times as mighty as they are. For
neither do men live nor die in vain.', 915, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('4e214cad4e881a9f76bbcb9dbe0e82ec5f45a64f5c42e8789fd3b88ea59620d4', 'Here and there they were scattered, nearly fifty altogether, in that
great gulf they had made, overtaken by a death that must have seemed to
them as incomprehensible as any death could be. To me also at that time
this death was incomprehensible. All I knew was that these things that
had been alive and so terrible to men were dead. For a moment I
believed that the destruction of Sennacherib had been repeated, that
God had repented, that the Angel of Death had slain them in the night.', 916, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('44b18fb72f43e2c86ea533b147b9f730478f253582b2a7505a893ead1d5d9b77', 'I stood staring into the pit, and my heart lightened gloriously, even
as the rising sun struck the world to fire about me with his rays. The
pit was still in darkness; the mighty engines, so great and wonderful
in their power and complexity, so unearthly in their tortuous forms,
rose weird and vague and strange out of the shadows towards the light.
A multitude of dogs, I could hear, fought over the bodies that lay
darkly in the depth of the pit, far below me. Across the pit on its
farther lip, flat and vast and strange, lay the great flying-machine
with which they had been experimenting upon our denser atmosphere when
decay and death arrested them. Death had come not a day too soon. At
the sound of a cawing overhead I looked up at the huge fighting-machine
that would fight no more for ever, at the tattered red shreds of flesh
that dripped down upon the overturned seats on the summit of Primrose
Hill.', 917, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('30aa56edfd61e1d6c460ff30335321263eba807136ff768bcfa3599a490fa910', 'I turned and looked down the slope of the hill to where, enhaloed now
in birds, stood those other two Martians that I had seen overnight,
just as death had overtaken them. The one had died, even as it had been
crying to its companions; perhaps it was the last to die, and its voice
had gone on perpetually until the force of its machinery was exhausted.
They glittered now, harmless tripod towers of shining metal, in the
brightness of the rising sun.', 918, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3c084334718c2758a0f362b9d45b93b42b0ac512854968219573ed5733f3e3c0', 'All about the pit, and saved as by a miracle from everlasting
destruction, stretched the great Mother of Cities. Those who have only
seen London veiled in her sombre robes of smoke can scarcely imagine
the naked clearness and beauty of the silent wilderness of houses.', 919, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('43e802e2d89a8deae0fdd6b73ce46b13b6714735d4fb80228472b3e519bc0fbc', 'Eastward, over the blackened ruins of the Albert Terrace and the
splintered spire of the church, the sun blazed dazzling in a clear sky,
and here and there some facet in the great wilderness of roofs caught
the light and glared with a white intensity.', 920, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('2c67e546c734ba8cf1db254d99dfe6cbfe3132ed22851fad47169800fb97c243', 'Northward were Kilburn and Hampsted, blue and crowded with houses;
westward the great city was dimmed; and southward, beyond the Martians,
the green waves of Regent’s Park, the Langham Hotel, the dome of the
Albert Hall, the Imperial Institute, and the giant mansions of the
Brompton Road came out clear and little in the sunrise, the jagged
ruins of Westminster rising hazily beyond. Far away and blue were the
Surrey hills, and the towers of the Crystal Palace glittered like two
silver rods. The dome of St. Paul’s was dark against the sunrise, and
injured, I saw for the first time, by a huge gaping cavity on its
western side.', 921, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6912abe48c5f3992b01a92ce3536e8414228a5b677cd029572637f1ee41e6b66', 'And as I looked at this wide expanse of houses and factories and
churches, silent and abandoned; as I thought of the multitudinous hopes
and efforts, the innumerable hosts of lives that had gone to build this
human reef, and of the swift and ruthless destruction that had hung
over it all; when I realised that the shadow had been rolled back, and
that men might still live in the streets, and this dear vast dead city
of mine be once more alive and powerful, I felt a wave of emotion that
was near akin to tears.', 922, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bbdc948464652fbb51e5fdabd2eb63b7ac1840e2626698a3a9999d41574be491', 'The torment was over. Even that day the healing would begin. The
survivors of the people scattered over the country—leaderless, lawless,
foodless, like sheep without a shepherd—the thousands who had fled by
sea, would begin to return; the pulse of life, growing stronger and
stronger, would beat again in the empty streets and pour across the
vacant squares. Whatever destruction was done, the hand of the
destroyer was stayed. All the gaunt wrecks, the blackened skeletons of
houses that stared so dismally at the sunlit grass of the hill, would
presently be echoing with the hammers of the restorers and ringing with
the tapping of their trowels. At the thought I extended my hands
towards the sky and began thanking God. In a year, thought I—in a year.
. . .', 923, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('74201ebd8de2e254f6ad48cb4acdc40dfc2ab91f39d190c68c29b08081dc723c', 'With overwhelming force came the thought of myself, of my wife, and the
old life of hope and tender helpfulness that had ceased for ever.', 924, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('24d1aff5ae0aab6439504336e2b9d5c2fe918f4ce5b37ad395d0f4fcfde4809e', 'Very gently, when my mind was assured again, did they break to me what
they had learned of the fate of Leatherhead. Two days after I was
imprisoned it had been destroyed, with every soul in it, by a Martian.
He had swept it out of existence, as it seemed, without any
provocation, as a boy might crush an ant hill, in the mere wantonness
of power.', 929, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('44714508cbd91f7b9628453f633638b9ebc47aa95d09aa93bae538a71694f262', 'I was a lonely man, and they were very kind to me. I was a lonely man
and a sad one, and they bore with me. I remained with them four days
after my recovery. All that time I felt a vague, a growing craving to
look once more on whatever remained of the little life that seemed so
happy and bright in my past. It was a mere hopeless desire to feast
upon my misery. They dissuaded me. They did all they could to divert me
from this morbidity. But at last I could resist the impulse no longer,
and, promising faithfully to return to them, and parting, as I will
confess, from these four-day friends with tears, I went out again into
the streets that had lately been so dark and strange and empty.', 930, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e5f921247f136cf0ebbeccfdbac8918cfc5fed6cb8743de244caacf504c7c661', 'Already they were busy with returning people; in places even there were
shops open, and I saw a drinking fountain running water.', 931, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a4b746e271164bc386b0e6126ecad06c2bf9ddc973029396c3892c5b90b751a2', 'I remember how mockingly bright the day seemed as I went back on my
melancholy pilgrimage to the little house at Woking, how busy the
streets and vivid the moving life about me. So many people were abroad
everywhere, busied in a thousand activities, that it seemed incredible
that any great proportion of the population could have been slain. But
then I noticed how yellow were the skins of the people I met, how
shaggy the hair of the men, how large and bright their eyes, and that
every other man still wore his dirty rags. Their faces seemed all with
one of two expressions—a leaping exultation and energy or a grim
resolution. Save for the expression of the faces, London seemed a city
of tramps. The vestries were indiscriminately distributing bread sent
us by the French government. The ribs of the few horses showed
dismally. Haggard special constables with white badges stood at the
corners of every street. I saw little of the mischief wrought by the
Martians until I reached Wellington Street, and there I saw the red
weed clambering over the buttresses of Waterloo Bridge.', 932, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3685860a96e0a1085982c9c47f8c98ce64eb0cb53841f4106858442ee38a383b', 'At the corner of the bridge, too, I saw one of the common contrasts of
that grotesque time—a sheet of paper flaunting against a thicket of the
red weed, transfixed by a stick that kept it in place. It was the
placard of the first newspaper to resume publication—the _Daily Mail_.
I bought a copy for a blackened shilling I found in my pocket. Most of
it was in blank, but the solitary compositor who did the thing had
amused himself by making a grotesque scheme of advertisement stereo on
the back page. The matter he printed was emotional; the news
organisation had not as yet found its way back. I learned nothing fresh
except that already in one week the examination of the Martian
mechanisms had yielded astonishing results. Among other things, the
article assured me what I did not believe at the time, that the “Secret
of Flying,” was discovered. At Waterloo I found the free trains that
were taking people to their homes. The first rush was already over.
There were few people in the train, and I was in no mood for casual
conversation. I got a compartment to myself, and sat with folded arms,
looking greyly at the sunlit devastation that flowed past the windows.
And just outside the terminus the train jolted over temporary rails,
and on either side of the railway the houses were blackened ruins. To
Clapham Junction the face of London was grimy with powder of the Black
Smoke, in spite of two days of thunderstorms and rain, and at Clapham
Junction the line had been wrecked again; there were hundreds of
out-of-work clerks and shopmen working side by side with the customary
navvies, and we were jolted over a hasty relaying.', 933, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cd1a4b96a0676ab6f4430d5054e77d6182ff3e361999eba80bf893f75c3c4b57', 'All down the line from there the aspect of the country was gaunt and
unfamiliar; Wimbledon particularly had suffered. Walton, by virtue of
its unburned pine woods, seemed the least hurt of any place along the
line. The Wandle, the Mole, every little stream, was a heaped mass of
red weed, in appearance between butcher’s meat and pickled cabbage. The
Surrey pine woods were too dry, however, for the festoons of the red
climber. Beyond Wimbledon, within sight of the line, in certain nursery
grounds, were the heaped masses of earth about the sixth cylinder. A
number of people were standing about it, and some sappers were busy in
the midst of it. Over it flaunted a Union Jack, flapping cheerfully in
the morning breeze. The nursery grounds were everywhere crimson with
the weed, a wide expanse of livid colour cut with purple shadows, and
very painful to the eye. One’s gaze went with infinite relief from the
scorched greys and sullen reds of the foreground to the blue-green
softness of the eastward hills.', 934, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('528a99acfecd91db2ef0d5ac3d1ee3fcb50c5dbfd5cf5bf01b310dd4efde4606', 'The line on the London side of Woking station was still undergoing
repair, so I descended at Byfleet station and took the road to Maybury,
past the place where I and the artilleryman had talked to the hussars,
and on by the spot where the Martian had appeared to me in the
thunderstorm. Here, moved by curiosity, I turned aside to find, among a
tangle of red fronds, the warped and broken dog cart with the whitened
bones of the horse scattered and gnawed. For a time I stood regarding
these vestiges. . . .', 935, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3b8ab255784330a855696716c4aa664397e8b37fba6fd73ca7ed8cd6377064e3', 'Then I returned through the pine wood, neck-high with red weed here and
there, to find the landlord of the Spotted Dog had already found
burial, and so came home past the College Arms. A man standing at an
open cottage door greeted me by name as I passed.', 936, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b83e772224ae30200468bdfe712cd12cc7c3b4c4b700a3c71ce759756c2d7c7c', 'I looked at my house with a quick flash of hope that faded immediately.
The door had been forced; it was unfast and was opening slowly as I
approached.', 937, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('41cd31665b2f027804596e6d3284aaf38c24d9dda9c60dfe8b2f7e9e08bdd0f3', 'It slammed again. The curtains of my study fluttered out of the open
window from which I and the artilleryman had watched the dawn. No one
had closed it since. The smashed bushes were just as I had left them
nearly four weeks ago. I stumbled into the hall, and the house felt
empty. The stair carpet was ruffled and discoloured where I had
crouched, soaked to the skin from the thunderstorm the night of the
catastrophe. Our muddy footsteps I saw still went up the stairs.', 938, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6074cb6e6643886c92f1dcb2ae90c4c994fd07bf0bc83bdabfa48eec54427450', 'I followed them to my study, and found lying on my writing-table still,
with the selenite paper weight upon it, the sheet of work I had left on
the afternoon of the opening of the cylinder. For a space I stood
reading over my abandoned arguments. It was a paper on the probable
development of Moral Ideas with the development of the civilising
process; and the last sentence was the opening of a prophecy: “In about
two hundred years,” I had written, “we may expect——” The sentence ended
abruptly. I remembered my inability to fix my mind that morning,
scarcely a month gone by, and how I had broken off to get my _Daily
Chronicle_ from the newsboy. I remembered how I went down to the garden
gate as he came along, and how I had listened to his odd story of “Men
from Mars.”', 939, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9671a4860e3a42d7750dbe14c2ae5a58d90e3a8b38fbc73db1a06e634b837ddd', 'I came down and went into the dining room. There were the mutton and
the bread, both far gone now in decay, and a beer bottle overturned,
just as I and the artilleryman had left them. My home was desolate. I
perceived the folly of the faint hope I had cherished so long. And then
a strange thing occurred. “It is no use,” said a voice. “The house is
deserted. No one has been here these ten days. Do not stay here to
torment yourself. No one escaped but you.”', 940, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ea4d7fff7daf7ef10df00701cb44161e6cb546121cee9581fb54ce0146d02099', 'I was startled. Had I spoken my thought aloud? I turned, and the French
window was open behind me. I made a step to it, and stood looking out.', 941, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('982f6d11787a1eca1eb813f9afee7b28d1ed9a94709046bbe7e1c463942c04f8', 'And there, amazed and afraid, even as I stood amazed and afraid, were
my cousin and my wife—my wife white and tearless. She gave a faint cry.', 942, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eea584eeff4de64e70b812b9d4fc9bbf25a43df7c4a20b8fae7426970050db96', '“I came,” she said. “I knew—knew——”', 943, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3602bb391c2cf870d0ae1e9c57fbb3f8d05289778f6c008b10a42ed5210452b8', 'She put her hand to her throat—swayed. I made a step forward, and
caught her in my arms.', 944, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1c1ad219a5f8e1aedb3f074b51c9686f805ec266a879189a9fac6c15e0cff0b4', '', 945, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('14ba89d560d2a3d06f07013f1ef995bb1802f358cce1566e8374fda42cdba87b', '
X.
THE EPILOGUE.', 946, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a2aa32bbad86b96f0c524f650e9dc9a4b3bfa281d0f8d327517751b6d5eaea69', '
I cannot but regret, now that I am concluding my story, how little I am
able to contribute to the discussion of the many debatable questions
which are still unsettled. In one respect I shall certainly provoke
criticism. My particular province is speculative philosophy. My
knowledge of comparative physiology is confined to a book or two, but
it seems to me that Carver’s suggestions as to the reason of the rapid
death of the Martians is so probable as to be regarded almost as a
proven conclusion. I have assumed that in the body of my narrative.', 947, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('d793a059ec5bbce372a1dcecd526e72afd1daebcd9576497f9712af273c41223', 'At any rate, in all the bodies of the Martians that were examined after
the war, no bacteria except those already known as terrestrial species
were found. That they did not bury any of their dead, and the reckless
slaughter they perpetrated, point also to an entire ignorance of the
putrefactive process. But probable as this seems, it is by no means a
proven conclusion.', 948, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fd627204d871b6a591c66cf662e0378749b39ca677779591666bafb360415d2d', 'Neither is the composition of the Black Smoke known, which the Martians
used with such deadly effect, and the generator of the Heat-Rays
remains a puzzle. The terrible disasters at the Ealing and South
Kensington laboratories have disinclined analysts for further
investigations upon the latter. Spectrum analysis of the black powder
points unmistakably to the presence of an unknown element with a
brilliant group of three lines in the green, and it is possible that it
combines with argon to form a compound which acts at once with deadly
effect upon some constituent in the blood. But such unproven
speculations will scarcely be of interest to the general reader, to
whom this story is addressed. None of the brown scum that drifted down
the Thames after the destruction of Shepperton was examined at the
time, and now none is forthcoming.', 949, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('500ba8258a34b3bdde75d4aeccb41510e31e2eb18fc7f36605ffcab49535b1b1', 'The results of an anatomical examination of the Martians, so far as the
prowling dogs had left such an examination possible, I have already
given. But everyone is familiar with the magnificent and almost
complete specimen in spirits at the Natural History Museum, and the
countless drawings that have been made from it; and beyond that the
interest of their physiology and structure is purely scientific.', 950, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f63c657aed7b37b06badbfa24ce38ac24403b789df85304bb18ad0bf8e8ba77e', 'A question of graver and universal interest is the possibility of
another attack from the Martians. I do not think that nearly enough
attention is being given to this aspect of the matter. At present the
planet Mars is in conjunction, but with every return to opposition I,
for one, anticipate a renewal of their adventure. In any case, we
should be prepared. It seems to me that it should be possible to define
the position of the gun from which the shots are discharged, to keep a
sustained watch upon this part of the planet, and to anticipate the
arrival of the next attack.', 951, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('88b5a8b3d2649b88cfa36c09419284a93a689e2550017c979fdbea9f8157878d', 'In that case the cylinder might be destroyed with dynamite or artillery
before it was sufficiently cool for the Martians to emerge, or they
might be butchered by means of guns so soon as the screw opened. It
seems to me that they have lost a vast advantage in the failure of
their first surprise. Possibly they see it in the same light.', 952, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('aa1e393d4bb97a6f91b4b674994499a29b0c2184ba06081b9ed7b8d8ab786f73', 'Lessing has advanced excellent reasons for supposing that the Martians
have actually succeeded in effecting a landing on the planet Venus.
Seven months ago now, Venus and Mars were in alignment with the sun;
that is to say, Mars was in opposition from the point of view of an
observer on Venus. Subsequently a peculiar luminous and sinuous marking
appeared on the unillumined half of the inner planet, and almost
simultaneously a faint dark mark of a similar sinuous character was
detected upon a photograph of the Martian disk. One needs to see the
drawings of these appearances in order to appreciate fully their
remarkable resemblance in character.', 953, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5dc6515a915e99810598dd2569dbd541b0dfb066c26abd2e5c42b4efd1ae3e56', 'At any rate, whether we expect another invasion or not, our views of
the human future must be greatly modified by these events. We have
learned now that we cannot regard this planet as being fenced in and a
secure abiding place for Man; we can never anticipate the unseen good
or evil that may come upon us suddenly out of space. It may be that in
the larger design of the universe this invasion from Mars is not
without its ultimate benefit for men; it has robbed us of that serene
confidence in the future which is the most fruitful source of
decadence, the gifts to human science it has brought are enormous, and
it has done much to promote the conception of the commonweal of
mankind. It may be that across the immensity of space the Martians have
watched the fate of these pioneers of theirs and learned their lesson,
and that on the planet Venus they have found a securer settlement. Be
that as it may, for many years yet there will certainly be no
relaxation of the eager scrutiny of the Martian disk, and those fiery
darts of the sky, the shooting stars, will bring with them as they fall
an unavoidable apprehension to all the sons of men.', 954, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fe31c63418c11161523d90795b6d11a0045f6474762884575cea2c79aba27047', 'The broadening of men’s views that has resulted can scarcely be
exaggerated. Before the cylinder fell there was a general persuasion
that through all the deep of space no life existed beyond the petty
surface of our minute sphere. Now we see further. If the Martians can
reach Venus, there is no reason to suppose that the thing is impossible
for men, and when the slow cooling of the sun makes this earth
uninhabitable, as at last it must do, it may be that the thread of life
that has begun here will have streamed out and caught our sister planet
within its toils.', 955, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('3c04d9702d11e217ad2953aee98eb2e6aa08647d456fc1173782240bcfa790a1', 'Dim and wonderful is the vision I have conjured up in my mind of life
spreading slowly from this little seed bed of the solar system
throughout the inanimate vastness of sidereal space. But that is a
remote dream. It may be, on the other hand, that the destruction of the
Martians is only a reprieve. To them, and not to us, perhaps, is the
future ordained.', 956, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f524d3810a18cb574295fe4e6d18b88239c6becfa79844d03ad17fbf297121fa', 'I must confess the stress and danger of the time have left an abiding
sense of doubt and insecurity in my mind. I sit in my study writing by
lamplight, and suddenly I see again the healing valley below set with
writhing flames, and feel the house behind and about me empty and
desolate. I go out into the Byfleet Road, and vehicles pass me, a
butcher boy in a cart, a cabful of visitors, a workman on a bicycle,
children going to school, and suddenly they become vague and unreal,
and I hurry again with the artilleryman through the hot, brooding
silence. Of a night I see the black powder darkening the silent
streets, and the contorted bodies shrouded in that layer; they rise
upon me tattered and dog-bitten. They gibber and grow fiercer, paler,
uglier, mad distortions of humanity at last, and I wake, cold and
wretched, in the darkness of the night.', 957, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a01145b461e49bc11377649d7974b22c16ee30aca769c464386cefef39ceae3f', 'I go to London and see the busy multitudes in Fleet Street and the
Strand, and it comes across my mind that they are but the ghosts of the
past, haunting the streets that I have seen silent and wretched, going
to and fro, phantasms in a dead city, the mockery of life in a
galvanised body. And strange, too, it is to stand on Primrose Hill, as
I did but a day before writing this last chapter, to see the great
province of houses, dim and blue through the haze of the smoke and
mist, vanishing at last into the vague lower sky, to see the people
walking to and fro among the flower beds on the hill, to see the
sight-seers about the Martian machine that stands there still, to hear
the tumult of playing children, and to recall the time when I saw it
all bright and clear-cut, hard and silent, under the dawn of that last
great day. . . .', 958, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('40f3e96a08f75dd48e49b6695a50c09c953397d9e3b72c822f9b8485e535942f', 'And strangest of all is it to hold my wife’s hand again, and to think
that I have counted her, and that she has counted me, among the dead.', 959, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('eab584926af4f4c1ef7fd88e098e34fc7326666a13e32a9ac46923f3ddde8475', '', 960, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('25b2c5fe1449fb3a5390b74eba5c260fcbc436205ffe39afa33970c1f848953e', '', 961, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('504ae490f971e52ec0d9e37a85675084b5352cd74a5d902db91bffdeca137c9d', '
*** END OF THE PROJECT GUTENBERG EBOOK THE WAR OF THE WORLDS ***', 962, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f236d52b2fa558e61ea4b1d688ada5603094cfefa1c601c547e10fe48cfae86c', '
    ', 963, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ead6c8b8d4ed68d47f6d5c74b36635e1df1753324fa0269c9dad9fae76fb2c49', 'Updated editions will replace the previous one—the old editions will
be renamed.', 964, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('00ae9833419d36d39b7a183b5a02f33264f2804cb7dcba9557ef08fee056094f', 'Creating the works from print editions not protected by U.S. copyright
law means that no one owns a United States copyright in these works,
so the Foundation (and you!) can copy and distribute it in the United
States without permission and without paying copyright
royalties. Special rules, set forth in the General Terms of Use part
of this license, apply to copying and distributing Project
Gutenberg™ electronic works to protect the PROJECT GUTENBERG™
concept and trademark. Project Gutenberg is a registered trademark,
and may not be used if you charge for an eBook, except by following
the terms of the trademark license, including paying royalties for use
of the Project Gutenberg trademark. If you do not charge anything for
copies of this eBook, complying with the trademark license is very
easy. You may use this eBook for nearly any purpose such as creation
of derivative works, reports, performances and research. Project
Gutenberg eBooks may be modified and printed and given away—you may
do practically ANYTHING in the United States with eBooks not protected
by U.S. copyright law. Redistribution is subject to the trademark
license, especially commercial redistribution.', 965, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('caf35130990742fd4c18820302e7f97b634c14090f8745de15925f72f869ab28', '
START: FULL LICENSE', 966, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('34b03a92121292d90bd50537248bd2e7879e3aa86c5f083691d0b6d020092748', 'THE FULL PROJECT GUTENBERG LICENSE', 967, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e439ad4d5dc8836834fe49be972e444a8e1a457f560648dda97de2e3aeca23ce', 'PLEASE READ THIS BEFORE YOU DISTRIBUTE OR USE THIS WORK', 968, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5eb65012153222acc010137d9c0ad717a69ce4ef310e1c53aded8bfb874e020f', 'References', 62, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('8cd2880b7f9164f8a0043d79c41827efe9d65217f0a411993d61792960b6921c', 'To protect the Project Gutenberg™ mission of promoting the free
distribution of electronic works, by using or distributing this work
(or any other work associated in any way with the phrase “Project
Gutenberg”), you agree to comply with all the terms of the Full
Project Gutenberg™ License available with this file or online at
www.gutenberg.org/license.', 969, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e3de2ebff88793f50f4974408b4d3fa894986604c0c35cc6b57dd42f159f774c', 'Section 1. General Terms of Use and Redistributing Project Gutenberg™
electronic works', 970, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bff42f2507667286168981957c0d4b4cdd38f10c50c22ad77c0879c1ac000827', '1.A. By reading or using any part of this Project Gutenberg™
electronic work, you indicate that you have read, understand, agree to
and accept all the terms of this license and intellectual property
(trademark/copyright) agreement. If you do not agree to abide by all
the terms of this agreement, you must cease using and return or
destroy all copies of Project Gutenberg™ electronic works in your
possession. If you paid a fee for obtaining a copy of or access to a
Project Gutenberg™ electronic work and you do not agree to be bound
by the terms of this agreement, you may obtain a refund from the person
or entity to whom you paid the fee as set forth in paragraph 1.E.8.', 971, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('195a23ea842d685ccf98ae3b0aeeb026123433dd8be306b181334d9984065bcb', '1.B. “Project Gutenberg” is a registered trademark. It may only be
used on or associated in any way with an electronic work by people who
agree to be bound by the terms of this agreement. There are a few
things that you can do with most Project Gutenberg™ electronic works
even without complying with the full terms of this agreement. See
paragraph 1.C below. There are a lot of things you can do with Project
Gutenberg™ electronic works if you follow the terms of this
agreement and help preserve free future access to Project Gutenberg™
electronic works. See paragraph 1.E below.', 972, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('51572f3adadb9ad2c50c767aaa9d2fd72a0578bd0b8b9645487247a3a533a74f', '1.C. The Project Gutenberg Literary Archive Foundation (“the
Foundation” or PGLAF), owns a compilation copyright in the collection
of Project Gutenberg™ electronic works. Nearly all the individual
works in the collection are in the public domain in the United
States. If an individual work is unprotected by copyright law in the
United States and you are located in the United States, we do not
claim a right to prevent you from copying, distributing, performing,
displaying or creating derivative works based on the work as long as
all references to Project Gutenberg are removed. Of course, we hope
that you will support the Project Gutenberg™ mission of promoting
free access to electronic works by freely sharing Project Gutenberg™
works in compliance with the terms of this agreement for keeping the
Project Gutenberg™ name associated with the work. You can easily
comply with the terms of this agreement by keeping this work in the
same format with its attached full Project Gutenberg™ License when
you share it without charge with others.', 973, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f4c016c75e096f4eb175168b3249f9b727244d4b6fe2f1285ec0f3f0d9f86586', '1.D. The copyright laws of the place where you are located also govern
what you can do with this work. Copyright laws in most countries are
in a constant state of change. If you are outside the United States,
check the laws of your country in addition to the terms of this
agreement before downloading, copying, displaying, performing,
distributing or creating derivative works based on this work or any
other Project Gutenberg™ work. The Foundation makes no
representations concerning the copyright status of any work in any
country other than the United States.', 974, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0b0abeca6feb15f6c92179961a58db05f4dbe0cde51547890718bfa698f801fc', '1.E. Unless you have removed all references to Project Gutenberg:', 975, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('bdd31d8189f98f19bd30d8c6e840dc4ad0b122762ba5f50fc16886cdb047d488', '1.E.1. The following sentence, with active links to, or other
immediate access to, the full Project Gutenberg™ License must appear
prominently whenever any copy of a Project Gutenberg™ work (any work
on which the phrase “Project Gutenberg” appears, or with which the
phrase “Project Gutenberg” is associated) is accessed, displayed,
performed, viewed, copied or distributed:', 976, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a4d4cc258b14b7f7c92bb995bb878d108f247a1a993849156ebe8f250460ff1d', '    This eBook is for the use of anyone anywhere in the United States and most
    other parts of the world at no cost and with almost no restrictions
    whatsoever. You may copy it, give it away or re-use it under the terms
    of the Project Gutenberg License included with this eBook or online
    at www.gutenberg.org. If you
    are not located in the United States, you will have to check the laws
    of the country where you are located before using this eBook.
  
1.E.2. If an individual Project Gutenberg™ electronic work is
derived from texts not protected by U.S. copyright law (does not
contain a notice indicating that it is posted with permission of the
copyright holder), the work can be copied and distributed to anyone in
the United States without paying any fees or charges. If you are
redistributing or providing access to a work with the phrase “Project
Gutenberg” associated with or appearing on the work, you must comply
either with the requirements of paragraphs 1.E.1 through 1.E.7 or
obtain permission for the use of the work and the Project Gutenberg™
trademark as set forth in paragraphs 1.E.8 or 1.E.9.', 977, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('34654b280bf1dd401bce07c42b769a90ffe44c97a8239563f5b13745a3108640', '1.E.3. If an individual Project Gutenberg™ electronic work is posted
with the permission of the copyright holder, your use and distribution
must comply with both paragraphs 1.E.1 through 1.E.7 and any
additional terms imposed by the copyright holder. Additional terms
will be linked to the Project Gutenberg™ License for all works
posted with the permission of the copyright holder found at the
beginning of this work.', 978, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9bfe8e54a245fa301f328f8eba912376ac2a58841202795bd422d39f7bd90c6e', '1.E.4. Do not unlink or detach or remove the full Project Gutenberg™
License terms from this work, or any files containing a part of this
work or any other work associated with Project Gutenberg™.', 979, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('93deb60f57ce3075f88bf96b4a175233157981aecdcfe9e546c7e3606b50eb09', '1.E.5. Do not copy, display, perform, distribute or redistribute this
electronic work, or any part of this electronic work, without
prominently displaying the sentence set forth in paragraph 1.E.1 with
active links or immediate access to the full terms of the Project
Gutenberg™ License.', 980, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8be94528dff713638f43f78a5eea18e91b2cff2fa8defa79b748eb99806f909c', '1.E.6. You may convert to and distribute this work in any binary,
compressed, marked up, nonproprietary or proprietary form, including
any word processing or hypertext form. However, if you provide access
to or distribute copies of a Project Gutenberg™ work in a format
other than “Plain Vanilla ASCII” or other format used in the official
version posted on the official Project Gutenberg™ website
(www.gutenberg.org), you must, at no additional cost, fee or expense
to the user, provide a copy, a means of exporting a copy, or a means
of obtaining a copy upon request, of the work in its original “Plain
Vanilla ASCII” or other form. Any alternate format must include the
full Project Gutenberg™ License as specified in paragraph 1.E.1.', 981, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a97d7b0ba90b5c8cf898033b21b6078cadee27d0dc55a5de496c9ecff50d839b', '1.E.7. Do not charge a fee for access to, viewing, displaying,
performing, copying or distributing any Project Gutenberg™ works
unless you comply with paragraph 1.E.8 or 1.E.9.', 982, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('5b2b02fe005ecaad1284f785a7ac77fa12eafb8576e22c0ae067b7eeea4d96a3', '1.E.8. You may charge a reasonable fee for copies of or providing
access to or distributing Project Gutenberg™ electronic works
provided that:', 983, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('1e20901ed03cb3cd1ad7c0a87cdb11d92357bff33a848c943a0f5affa3354f7b', '    • You pay a royalty fee of 20% of the gross profits you derive from
        the use of Project Gutenberg™ works calculated using the method
        you already use to calculate your applicable taxes. The fee is owed
        to the owner of the Project Gutenberg™ trademark, but he has
        agreed to donate royalties under this paragraph to the Project
        Gutenberg Literary Archive Foundation. Royalty payments must be paid
        within 60 days following each date on which you prepare (or are
        legally required to prepare) your periodic tax returns. Royalty
        payments should be clearly marked as such and sent to the Project
        Gutenberg Literary Archive Foundation at the address specified in
        Section 4, “Information about donations to the Project Gutenberg
        Literary Archive Foundation.”
    
    • You provide a full refund of any money paid by a user who notifies
        you in writing (or by e-mail) within 30 days of receipt that s/he
        does not agree to the terms of the full Project Gutenberg™
        License. You must require such a user to return or destroy all
        copies of the works possessed in a physical medium and discontinue
        all use of and all access to other copies of Project Gutenberg™
        works.
    
    • You provide, in accordance with paragraph 1.F.3, a full refund of
        any money paid for a work or a replacement copy, if a defect in the
        electronic work is discovered and reported to you within 90 days of
        receipt of the work.
    
    • You comply with all other terms of this agreement for free
        distribution of Project Gutenberg™ works.
    ', 984, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c60c1a69640fd68c01d6a715279221d346e63b47009dea3978a9fe7b8b0d2251', '1.E.9. If you wish to charge a fee or distribute a Project
Gutenberg™ electronic work or group of works on different terms than
are set forth in this agreement, you must obtain permission in writing
from the Project Gutenberg Literary Archive Foundation, the manager of
the Project Gutenberg™ trademark. Contact the Foundation as set
forth in Section 3 below.', 985, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ad677c799883f1ef04f5c81dfcafbec900f8e2c3b71752581da086cd33b0c9f2', '1.F.', 986, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('0f8cbe107a66ff827fb3287dc152d5c8a5aee8edf6de884008c18f2bb2c4663a', '1.F.1. Project Gutenberg volunteers and employees expend considerable
effort to identify, do copyright research on, transcribe and proofread
works not protected by U.S. copyright law in creating the Project
Gutenberg™ collection. Despite these efforts, Project Gutenberg™
electronic works, and the medium on which they may be stored, may
contain “Defects,” such as, but not limited to, incomplete, inaccurate
or corrupt data, transcription errors, a copyright or other
intellectual property infringement, a defective or damaged disk or
other medium, a computer virus, or computer codes that damage or
cannot be read by your equipment.', 987, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('dfb485dcb76428596fa3acf150e3ebe748c250ae8c23a1de4cde54ec13ec9cf0', '1.F.2. LIMITED WARRANTY, DISCLAIMER OF DAMAGES - Except for the “Right
of Replacement or Refund” described in paragraph 1.F.3, the Project
Gutenberg Literary Archive Foundation, the owner of the Project
Gutenberg™ trademark, and any other party distributing a Project
Gutenberg™ electronic work under this agreement, disclaim all
liability to you for damages, costs and expenses, including legal
fees. YOU AGREE THAT YOU HAVE NO REMEDIES FOR NEGLIGENCE, STRICT
LIABILITY, BREACH OF WARRANTY OR BREACH OF CONTRACT EXCEPT THOSE
PROVIDED IN PARAGRAPH 1.F.3. YOU AGREE THAT THE FOUNDATION, THE
TRADEMARK OWNER, AND ANY DISTRIBUTOR UNDER THIS AGREEMENT WILL NOT BE
LIABLE TO YOU FOR ACTUAL, DIRECT, INDIRECT, CONSEQUENTIAL, PUNITIVE OR
INCIDENTAL DAMAGES EVEN IF YOU GIVE NOTICE OF THE POSSIBILITY OF SUCH
DAMAGE.', 988, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fb57d04003bb27d1e70fd8491a70c96fbe8ed952cc86eac9cc5edee423cbb045', '1.F.3. LIMITED RIGHT OF REPLACEMENT OR REFUND - If you discover a
defect in this electronic work within 90 days of receiving it, you can
receive a refund of the money (if any) you paid for it by sending a
written explanation to the person you received the work from. If you
received the work on a physical medium, you must return the medium
with your written explanation. The person or entity that provided you
with the defective work may elect to provide a replacement copy in
lieu of a refund. If you received the work electronically, the person
or entity providing it to you may choose to give you a second
opportunity to receive the work electronically in lieu of a refund. If
the second copy is also defective, you may demand a refund in writing
without further opportunities to fix the problem.', 989, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ae8119b3237112b933e9d0dbab8228f2eadc56f9258fe6aeb8305a5420201e7c', '1.F.4. Except for the limited right of replacement or refund set forth
in paragraph 1.F.3, this work is provided to you ‘AS-IS’, WITH NO
OTHER WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO WARRANTIES OF MERCHANTABILITY OR FITNESS FOR ANY PURPOSE.', 990, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('32caccbb48279447c65c1c45c484f6e216f1ec9db7787b0539a7ffbe5c6e2f75', '1.F.5. Some states do not allow disclaimers of certain implied
warranties or the exclusion or limitation of certain types of
damages. If any disclaimer or limitation set forth in this agreement
violates the law of the state applicable to this agreement, the
agreement shall be interpreted to make the maximum disclaimer or
limitation permitted by the applicable state law. The invalidity or
unenforceability of any provision of this agreement shall not void the
remaining provisions.', 991, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('fd8fef0e81f671c75d5b7e79e7e27147d2c8f292714ec73edc58a034bbc01277', '1.F.6. INDEMNITY - You agree to indemnify and hold the Foundation, the
trademark owner, any agent or employee of the Foundation, anyone
providing copies of Project Gutenberg™ electronic works in
accordance with this agreement, and any volunteers associated with the
production, promotion and distribution of Project Gutenberg™
electronic works, harmless from all liability, costs and expenses,
including legal fees, that arise directly or indirectly from any of
the following which you do or cause to occur: (a) distribution of this
or any Project Gutenberg™ work, (b) alteration, modification, or
additions or deletions to any Project Gutenberg™ work, and (c) any
Defect you cause.', 992, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('a0b1468303fff8602021e66696ec116c1d96ff9944ba1fedf4386e7773a247a4', 'Section 2. Information about the Mission of Project Gutenberg™', 993, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('80927e8e9be83224f0bef33bfe7366d2dec5f7265ebb132f5e812f1fd264882f', 'Project Gutenberg™ is synonymous with the free distribution of
electronic works in formats readable by the widest variety of
computers including obsolete, old, middle-aged and new computers. It
exists because of the efforts of hundreds of volunteers and donations
from people in all walks of life.', 994, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('af2bb9d7598aefcc94791d381c43af152bcfa69e1abb0002bf4cee783882e0e9', 'Volunteers and financial support to provide volunteers with the
assistance they need are critical to reaching Project Gutenberg™’s
goals and ensuring that the Project Gutenberg™ collection will
remain freely available for generations to come. In 2001, the Project
Gutenberg Literary Archive Foundation was created to provide a secure
and permanent future for Project Gutenberg™ and future
generations. To learn more about the Project Gutenberg Literary
Archive Foundation and how your efforts and donations can help, see
Sections 3 and 4 and the Foundation information page at www.gutenberg.org.', 995, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('70fbab6a88e39a4b478068b8290da2434d878f147f181d9ff86442cb7492371b', 'Section 3. Information about the Project Gutenberg Literary Archive Foundation', 996, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('b4e5fc09ec920826e02b876818337a12d6cc8b64e051ab82f08ea1f8dbfb50ab', 'The Project Gutenberg Literary Archive Foundation is a non-profit
501(c)(3) educational corporation organized under the laws of the
state of Mississippi and granted tax exempt status by the Internal
Revenue Service. The Foundation’s EIN or federal tax identification
number is 64-6221541. Contributions to the Project Gutenberg Literary
Archive Foundation are tax deductible to the full extent permitted by
U.S. federal laws and your state’s laws.', 997, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('cd699c961588c2d6c245e65504d71a14d02aaab77285c6acff0318760325baeb', 'The Foundation’s business office is located at 809 North 1500 West,
Salt Lake City, UT 84116, (801) 596-1887. Email contact links and up
to date contact information can be found at the Foundation’s website
and official page at www.gutenberg.org/contact', 998, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('44ea8e249802a06e8034ce2d3efc4954f71389657265d2918c0fafc6fc084abe', 'Section 4. Information about Donations to the Project Gutenberg
Literary Archive Foundation', 999, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('77d819910552be2c88b90896cf97177e748771438c4503610cb243f4634091ff', 'Project Gutenberg™ depends upon and cannot survive without widespread
public support and donations to carry out its mission of
increasing the number of public domain and licensed works that can be
freely distributed in machine-readable form accessible by the widest
array of equipment including outdated equipment. Many small donations
($1 to $5,000) are particularly important to maintaining tax exempt
status with the IRS.', 1000, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('9ebdcf5d5fcb8054d3068ec709179385f241dda09a8c538669a421ba51eea2c1', 'The Foundation is committed to complying with the laws regulating
charities and charitable donations in all 50 states of the United
States. Compliance requirements are not uniform and it takes a
considerable effort, much paperwork and many fees to meet and keep up
with these requirements. We do not solicit donations in locations
where we have not received written confirmation of compliance. To SEND
DONATIONS or determine the status of compliance for any particular state
visit www.gutenberg.org/donate.', 1001, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('096183bf91846789d18f8ffc9ce647590c3928d566287fcb450ca9a9de824ed4', 'While we cannot and do not solicit contributions from states where we
have not met the solicitation requirements, we know of no prohibition
against accepting unsolicited donations from donors in such states who
approach us with offers to donate.', 1002, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('e8101eda6e67930bc1eaa5c037bf361b2f51c35b9a132c491858b02d553fc421', 'International donations are gratefully accepted, but we cannot make
any statements concerning tax treatment of donations received from
outside the United States. U.S. laws alone swamp our small staff.', 1003, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('ea3c79cbde1cc22314bcf3c8fa4eda1bf70f1e84adbb91ea44dba4f5a9650590', 'Please check the Project Gutenberg web pages for current donation
methods and addresses. Donations are accepted in a number of other
ways including checks, online payments and credit card donations. To
donate, please visit: www.gutenberg.org/donate.', 1004, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('115aeee1ec5ee664b0c7de08fcec6fa7e07400e84bea96f839d9d61d6ec6899c', 'Section 5. General Information About Project Gutenberg™ electronic works', 1005, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('8ab440450f313ec050084d971fd356c73113fabed19ceba94f92fb59b79caa2b', 'Professor Michael S. Hart was the originator of the Project
Gutenberg™ concept of a library of electronic works that could be
freely shared with anyone. For forty years, he produced and
distributed Project Gutenberg™ eBooks with only a loose network of
volunteer support.', 1006, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('f247ea786f727519d134e510b46d50fadc133305770e2eed657840684eee130c', 'Project Gutenberg™ eBooks are often created from several printed
editions, all of which are confirmed as not protected by copyright in
the U.S. unless a copyright notice is included. Thus, we do not
necessarily keep eBooks in compliance with any particular paper
edition.', 1007, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('db4eb36b17e45f84cee7439d9a9a8aa85b8634ee87556e6e473e26a2caf58901', 'Most people start at our website which has the main PG search
facility: www.gutenberg.org.', 1008, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('c1161c75e0741bb14275861de4454ee31cd6fe9eb52b5279ed7d0f485a093044', 'Data Structured  Image Search
Data
+ |, Extracted | Metadata Extraction |, Document', 31, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('587b4996d4b0c5c69542b3131f3009da2a0418c6c51533ed841632f618f4dbcc', 'This website includes information about Project Gutenberg™,
including how to make donations to the Project Gutenberg Literary
Archive Foundation, how to help produce our new eBooks, and how to
subscribe to our email newsletter to hear about new eBooks.', 1009, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('33d27f46f6a5ee45e8833f0d0e1cd5f6c2723558ae52854f90abbad72ee9b076', '
', 1010, 'c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a');
INSERT INTO public.chunks VALUES ('6392e68353862b70f48d8212af865529c299af8a7d7d7a7e3a0e841f8935160a', '
N.M. Hernandez, P.J. Lucafias'', J.C. Graciosa'', C. Mamador, L. Caezar'', I. Panganiban, C. Yu'', K.G.
Maver*, M.G. Maver
'' Traya Energies, 7 KGM geoconsulting', 0, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('741bc1102c35d90b3fc575648c21783ccc414c2f90889a3607fec7dcb2523237', 'Summary', 1, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('676636a6dec46dd87097357b826a5f8e009a5b6d2992763c10680cdc23e47b97', 'There is a large amount of historic and valuable well information available stored either on paper and more
recently as digital documents and reports in the oil and gas industry especially by national data management
systems and oil companies, These technical documents contain valuable information from disciplines like
geoscience and engineering and are in general stored in a unstructured format. To extract and utilize all this well
data, a machine learning-enabled platform, consisting of a carefully selected sequence of algorithms, has been
developed as a hybrid cloud container that automatically reads and understands the technical documents with little
human supervision. The user can upload raw data to the platform, which are stored on a private local server. The
machine learning algorithms are activated and implement the necessary processing and workflows. Structured
data is generated as output, which are pushed through to a search engine that is accessible to the user in the cloud.
The aim of the platform is to ease the identification of important parts of the technical documents, automatically
extract relevant information and visualize it for the user, so they can easily do further analysis, share it with
colleagues or agnostically port it to other platforms as input.', 2, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('bee30ae50db51a5cb85db549669c1baae9ece92d13c73c524e8fdb0fd47759d3', 'First EAGE/PESGB Workshop on Machine Learning', 3, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('1d5f100b6c354937c97259358a10e8c7df0194cd6f55f9911e3e75b28f3d8db9', '
Introduction', 4, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('fc4ce68be547fa451a1d115a612fd4231bbe53d2600086190feb0caf9395b2d7', 'There is a large amount of historic well information available stored either on paper and more recently
as digital documents and reports in the oil and gas industry. These technical documents contain
valuable information from diverse disciplines such as geology, geophysics, petrophysics, reservoir
engineering, drilling and other subject matters and are in general stored in a unstructured format.', 5, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('e10c622a7f85d1a49987f3643ff5f47fd436fb8313d664bf995bd565fe3a047b', 'Especially national data management systems and oil companies hosts these large amounts of very
valuable historical well data, which contain information such as reservoir metadata, images, texts, and
processed information, such as lithology, geology, shows, drilling risks etc. Due to the large volume,
vintage variety, and non-standard formats, extraction of valuable information, which can be used as
input for further work, is an arduous task as the manual nature of data mining is very time-consuming.', 6, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('9f0edaa21f4b302b292d7c55da25897bcb9c39ee17677ac09197e493ab78890b', 'To extract and utilize all this well data, a machine learning-enabled platform has been developed as a
hybrid cloud container that automatically reads and understands hundreds or thousands of technical
documents with little human supervision. The aim of the platform is to ease the identification of
important parts of the technical documents, automatically extract relevant information and visualize it
for the user, so they can easily do further analysis, share it with colleagues or agnostically port it to
other platforms as input.', 7, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('7247d17096114eb8a7a4ffa87299804b1dd089ac455099552b08c5594892bca4', 'Methodology', 8, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('1cb1a61ec2436a69b77c1f101cb4c9c26a09c1226f05dc86ea5347de1c8b6e8b', 'The platform utilizes a hybrid data service architecture, which leverages the 2-tier strength of both
cloud and private servers. The hybrid architecture serves to:', 9, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('503a0f3f4091174a52f1502ca49ea8843ca6250abc98cf58e16d0075a4e5e47a', 'Enhance the platforms security and data privacy by storing raw data locally
Increase data shareability in real-time by utilizing a cloud solution', 10, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('42b282e007d87b56ad50c260be1040a2ddb1ced462a0c8469e18aa86bf90f3a7', 'Reduce data redundancy and increase data integrity among users', 11, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('8bb11d19d88e5efc4be1f8bc7efdb5460edb81266d2ce1750b47ee4dd82e6a6d', 'Provide a pragmatic solution to optimize data storage costs', 12, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('0cc96c650298698d0360cf7a6064bc1bd1f65d7ba4e11a864f20204e10f03faf', 'The user can upload raw data to the platform, which are stored on a private local server. The machine
learning algorithms are activated and implement the necessary processing and workflows. Structured
data is generated as output, which are pushed through to a search engine that is accessible to the user
in the cloud (Figure 1).', 13, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('4a30298538addbd13b8ae737c5b3e42884b077f60cfef17eeca5deb26eb89e51', 'Figure 1 The hybrid architecture of platform (ElasticDocs) utilizing the 2-tier strength of local and
cloud sever applications for data security, integrity and shareability. Carefully selected machine
learning sequence for automated text and image analysis include: optical character recognition, deep
convolutional neural network and image clustering.', 14, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('f240c806fdf0c915846f5b478edc3cef6f8ee25e20add57a72974c7da1bea7f8', 'Machine Learning', 15, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('a086cd25906f56a83dfafea7b298829906fdc31786ff99cbfbf0562c9251a3bd', '
The platform capitalizes on the machine learning algorithms that automatically process the
unstructured data into a condensed format in which only pre-selected information are stored. The
machine learning algorithms employs a unique sequence of separate steps, which are set-up to mimic
the human experience of processing unstructured documents.', 16, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('4bbdc59a02f7f7fe930619f27b5ac0d111bcf09ab82a1b6640c49290064df59a', 'Workflow', 17, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('b0bdbd4e0c7da631714af68b98f87bc1111406e3b93d4694486fbaa92c729bce', 'For the unstructured data the first machine learning step is the digitization and conversion of .pdf or
.docx file formats into an editable format. This conversion uses Optical Character Recognition (OCR),
where the machine identifies each character in the image.', 19, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('73a4dd0fa5be7d215969ee8cd4bacbf415a4a7373f4579db0432c03725ac5c0c', 'After the documents are digitized important information has to be identified. This metadata extraction
and tagging utilizes Natural Language Processing (NLP) to tokenize each digitized text and identify
terms of significant value. Named Entity Recognition (NER) is then performed to create a model to
extract the metadata like well name, basin, permit, operator, well classification, latitude, longitude,
spudding date, kelly bushing etc.', 20, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('69e1828dd5b691f9caff2306f3978ff3cf85e72621da71ee432db18b7db48b98', 'For the images extracted by the digitization process, a modified VGG-16 neural network is used to
automatically classify tables, charts, stratigraphic chart images, maps, seismic, core samples and
scanning electron microscope images within each document (Simonyan ef al., 2014)', 21, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('00827673fc818cf11f350dee5fd41ad14489a7b47bc3a5b16821e51b3221bdca', 'For the visualization of the images an at-Distributed Stochastic Neighbor Embedding (t-SNE)
algorithm is used to quantify the similarity of each image, which has been developed to visualize
high-dimensional datasets and reveal clustering within the datasets (van der Maaten e al., 2008).', 22, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('b2bf9c7c982be653930ff8a3d60812920753536bea53013a8b0ae45823600758', 'The output from the machine learning sequence is then exposed to the users through the platform to
ease the work of identifying important information and perform analysis in a more efficient way. The
extracted information is outputted in an agnostic format, which can be efficiently loaded to other
platforms or used as is, ie. X, Y or Latitude/Longitude, formation tops in csv or excel format,
digitized maps as shapefile for loading into GIS software.', 23, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('d618cebdfbad2b38bc56ab5f56e3ee53025f77dd69718bd3721de7bd969cc771', 'Discussion and conclusion', 24, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('3760483b07e75640d7d9008ebcbf66f194389692a5fa0d3326d8c29ded5a38d5', 'Wells provide key information about the subsurface in oil and gas exploration and production but at a
substantial cost. As this valuable information associated with a well is often stored as unstructured
data, it is difficult to do further analysis or apply additional artificial intelligence processing to the
well database to enable geoscientists to gain new insights and extract new relationships.', 25, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('202248572ec5166593ee0f0a38f4082609a47d551304584796b3fe0cf89475c8', 'The carefully selected sequence of machine learning algorithms in the workflow deals with these
large unstructured datasets, is housed within a hybrid cloud platform to automatically extract relevant
information within technical documents and convert the unstructured data into a shareable structured
dataset.', 26, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('8941f4f89b6b92ac54ea52ae7c42165acb152807d355d3bfb01f521c0b52a278', 'References', 27, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('375235850c015c4df66465e9f915efb2f608932c1d9f64bfcbbda800c4c090ec', 'Simonyan, K. & Zisserman, A., 2014: Very Deep Convolutional Networks for Large-scale Image
Recognition. arXiv preprint arXiv: 1409.1556', 28, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('a2ead5d2164107bf256bcc85f2239be5d0900b30c235ffb08d7b5099310aaf23', 'van der Maaten, L.J.P. & Hinton G.E., 2008]: Visualizing High-Dimensional Data using t-SNE.
Journal of Machine Learning Research, 9, 2576-2605.', 29, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('8d40476dad05630fc1f1e113cdf01dc9fde6934f7ef409bd98ef00b9fdae1758', 'on Machine Learning', 30, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('c60247b1390d4e27b5c2e70c9f1d624617e65424843a1f2822ab783a2b69e150', '', 31, '8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740');
INSERT INTO public.chunks VALUES ('ed8d88b342216b38ca130f655b4b4a56fbbe4fa823f231cbd3864230b0e3c0ab', '
A CASE STUDY OF UNDERSTANDING THE
BONAPARTE BASIN USING UNSTRUCTURED DATA
ANALYSIS WITH MACHINE LEARNING TECHNIQUES', 0, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('691696ffc7450d485a546629455d2d37c3a05033a3465a9ccdbca05420a6858b', 'AN. Sazali!, N.M. Hernandez, F. Baillard'', K.G. Maver!', 1, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('8e574c6ddb028edb5afabef3a101e1bf378659f3d13052780b2efb1982eca35d', '''Traya Energies', 2, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('fccce1fd1a31465b92a1c7d8bbc4c9527f194f7a76b8f1a6090f70d5b00bc79d', 'Summary', 3, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('345b4b21885ab00b019aeca0b6ee0b7cf3731dca41730876f4e91954ee824736', 'As part of exploration and production the oil and gas industry produce substantial amounts of data
within different disciplines of which 80% are unstructured like reports, presentations, spreadsheets etc.
The value of technical work is reduced due to the lack of time available for analysis and critical
thinking and the under-utilization of the data. To assist geoscientist and engineers, Machine Learning
(ML) and Artificial Intelligence (AI) technologies are applied to process the unstructured data from
440 wells from the Bonaparte Basin in Australia making it possible to perform more accurate analysis
and make faster decisions.', 4, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f4ec26b53f17d3642355d06cd5c487a2f60ba4352e2f38c477ca59da68dd1aa5', 'Based on the play-based exploration pyramid concept, the time spent at the Basin Focus stage can be
reduced, and more time are available to focus on the other project stages. The explorationist will be
able to bring more value to the study.', 5, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('22793746f502ea47e98e749fa1219948810712629efc42cb0aca68f34cf2b19d', 'It will be shown that potential issues encountered during exploration of the Bonaparte Basin can be
identified. Based on a quick look and gathering of all information it can be concluded that most of the
production in the Bonaparte Basin is from Jurassic and Triassic with observed net pay of 18-60m
thickness, porosity of 11-29% and saturation of 11-55% Sw.', 6, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f12e90a689b774b5d0d5e62611556ca5d9f14674c053bb1c4d7a3a7db363556d', '', 7, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('4293c90e00063c9684767fdc61e92a8d915bc4a05fb9fd262483df191b14ff78', 'A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with
Machine Learning Techniques', 8, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('c3ab4c07da2c3db449a309405c398a1d29bd78c171b45c9c1a3a45dcd1d6ba78', 'As part of exploration and production the oil and gas industry produce substantial amounts of data
within different disciplines of which 80% are unstructured like reports, presentations, spreadsheets etc
and it is expected to grow exponentially. As a result, geoscientists and engineers spend 50 to 80% of
their time searching and assembling data and only 1 to 5% of the data is fully utilized. The value of
technical work is therefore reduced due to the lack of time available for analysis and critical thinking
and the under-utilization of the data. To assist geoscientist and engineers, Machine Learning (ML)
and Artificial Intelligence (AI) technologies are applied to process the unstructured data making it
possible to perform more accurate analysis and make faster decisions.', 10, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('d1c47e154d67e350f51245256609d520b9fa4ea2e9dc27aac40cde09b1033a40', 'In this case study the area of interest covers Bonaparte Basin, which is located north-west of
the Australian continental margin (Figure 1). It joins the Money Shoal basin in the north-east and
the Browse Basin in the south-west. Furthermore, the Timor Trough defines the northern boundary.
The areal extent of the basin is approximately 270,000 sq. km. The objective of this study is to
understand and obtain meaningful insights into the Bonaparte Basin based on the substantial amount
of information available in previous studies, reports and presentations. The unstructured data of the
Bonaparte Basin have been ingested in a Knowledge Container through consecutive ML and AI
pipelines and analysed using big data analytics tools.', 11, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('9aa48dcce1fc49d31e129d971abd3169c8fe3874dd9ce10c647feb9bc6bf5f82', 'Consist of several structural elements :
@ Ashmore Platform  Malita Graben
 Vulcan Sub-Basin  Sahul Platform', 12, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('c292dbe718c2ac2bf525a6432d726966f24bb9c4e53dc76a42b2f83e9415bfac', ' Londonderry High @ Flamingo High
 Petrel Sub-basin @ Flamingo Syncline
 Darwin Shelf @ Sahul Syncline
@ Calder Graben  Nancar Trough
@ Troubadour Terrace Laminaria High
Figure 1 Location of the Bonaparte Basin within the Australian continental margin (left) and 14
structural elements observed within the Bonaparte Basin (right).', 13, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('a828a7ba115e16bc437d51243dcfe5e2ec683791ae586847d394549c0813487d', 'Methodology', 14, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('9233c0f9a88c49f18350b9ce1dc7abcb47df70dc5ed3015a3a2f9f93b8079258', 'As of 2021, the Bonaparte Basin encompasses 440 wells representing 58 years of exploration history
summarized in over 270,000 pages of documents and in 250,000 images. It is estimated that billions of
dollars have been invested over the years to acquire and interprete the data, making it a substantial
source of information for new exploration activities.', 15, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e0d342e441af05af8dfbf2968e46ea67ed01037edf9a50442e7055531c8094f4', 'The Play Based Exploration (PBE) approach is often used as a traditional framework to refine the
geoscientistss understanding from a broad basin level to a narrow prospect focus (Lottaroli et al., 2016).
As a start such an approach often involves capturing the current state of knowledge with massive
background resources to understand and analyse the key features of the basin and the major risks
associated to it. Such information is primarily available in unstructured data, requiring geoscientist and
engineers to process and ingest the information before focusing on a specific play and prospect using
structured data. Therefore, we have modified the existing PBE pyramid to introduce an additional', 16, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f6fee366c01b339cb69235ca54bd3018fe9031b86b2cfeb86d50ca835680910b', '', 17, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('98c1adf6e72a700ca2e41827311c5f4229ca3f25672ee038dfbb92c1db651e44', 'dimension associated with data science identifying the different types of data available at different
stages, allowing us to better define the best suited ML/AI strategy for a given stage (Figure 2).', 18, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('56fc673fcb46eb7a636f0bf91acd2acf119336a8423a19b5397527d19cff6830', 'STRUCTURED', 19, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('0c606563df5c5578619781d567fa43d5ec840a0038d2d42224ccb783a0f51bee', 'Tora nercare cercest
UNSTRUCTURED  8 rence siento renown, se 30008)', 20, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('61a9cd2da4e164104dfe1544edba01b928c50dc59fb985de159e5d22a213b5d8', 'of being present and effective over 20,', 21, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('2c3038fd28344319a911f4185b2a0b7d1a55045744e8c59f38f7b398ec65ceae', '@ Assess the possibsty a play may
exiets ina basin', 22, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e27d697d52975ee23d373bee4cacc380e899ba47b4fc3da55da238c672352bfd', 'Figure 2 Customized Play Based Exploration (PBE) pyramid with ML technology (Modified from
Lottaroli et al., 2016).', 23, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('d997c6ad152a7acf45e50d0523615bb4b35175583334ea189bdd7b710b8247be', 'Focusing on the unstructured data associated with the Basin and Play Analysis, all the data from the
Bonaparte Basin have been processed through a succession of AI/ML automated pipeline such as
Natural Language Processing or Deep Convolutional Neural Network (Hernandez et al., 2019), (Figure
3). The sharable structured data is then further processed through deeper level of analytics to detect
trends and anomalies present within the data. Machine assistance is heavily used in repetitive tasks early
in the process during the processing of the data and up to 95% of the tasks will be performed by the
machine. This provides additional time for the specialist to focus on critical thinking and cognitive skills', 24, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('ca32e6663d705c6ce02609c9206f9c4b577f7d3c1c44cf83b4c0dc9eef529f0c', 'to interpret the data.', 25, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('2d18fab8c6c17f0ca4883b4144c8d7489b2ab5b4d3bab733f88856079027f4fc', 'MACHINE LEARNING PIPELINE ANALYTICS GEOLOGICAL INSIGHTS', 26, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e6046c2c0ad5b5d869343bb5c34655870bd9f5c98a2b54bc592835cd0dd8e7e0', 'Early intespretation on', 27, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('5311c49a3a7d8cbb996714c4e1583ea7a07eed11595d8743481e1a78d0146b4f', '* lithology Cloud Geological environment', 28, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('96fe6de0d343462f058b07fd9606e6876ea6c6c1f5921024463e146fb6cd879a', 'Text Search = ~ Data are geospatially
+ Image Classification - +  distributed on maps for
Deep Convolutional trends and anomalies', 29, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('61884a6eabd111c4dd838a9d2261e6ab0797f74a338f26085910de4191ff3203', 'Unstructured Neural Network Sharable observation', 30, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('8f40171c7daea6f799f64fc72897dfbd3016e9f53639b4a3bcd833a53f1fce42', 'Early trend can be observed
across the whole basin', 34, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f13da5a2cdce4b90a5fe44a3b4c51694fec3f9a290cf212cc521e4b33a97e67c', 'Identify well analogues and', 35, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f03ee4bd2c563e2ec9c80c9535814149749c2524bf277ddbe49d2b765dbde2de', '* Knowledge Graph - * relationship between wells', 36, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('de0910538a1d66bfc04bb8fa58694cdab03953acd342ea6da3374b3bc05f3c4a', '95% 1909  6) ', 37, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('6eaa2586aa998022cd6f1bec647583a07e7d317604a55b6ba4ccaca4c6d359b2', 'MI/AI sequence automated with Analytics tools for data display Hurnan high-level interpretation
human in the loop for QC
9,', 38, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('57a3ba0fa85aa209baaa0c7652d10b4e2b1524049b319c687efec375c2bd5805', 'tue oN $$ 5% 40% mee |', 39, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('454082a64d5fade48a207d0db706e8697023f3a5737800c679a03ef35c908784', 'Figure 3 Unstructured Big Data pipeline', 40, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('a05dd222904d4d16aba8ff4821945170c8ce8aa8048ce15d701fa9db9df98088', 'In this case study, interpretation using the Big Data workflow was used to understand the exploration
history, how the basin developed, its petroleum system and the main issue of the dry wells occurrence
to avoid repeating the mistakes of the past and improve future decision making.', 41, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('c779897288340bcbffa2beefe0c13102e46d2c290a6051d1db21d74bbea159ae', '', 42, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('5c3eb8f19486f27ea32963fd32c53ec873ba4588bab6351ef0bf4dd92ad9f35a', 'By analysing the data, five potential issues are identified i.e. (i) Discrepancies in Formation Tops, (ii)
Limited understanding of Lithology Distribution, (iii) Limited Mineral Composition Understanding,
(iv) Fluid Distribution, and (v) Pressure/Temperature Patterns. Each potential issue is tackled by
identifying trends and anomalies across the basin using images, tables and plots extracted from the
unstructured data corpus.', 43, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('6117a14151a0052cccef2c34a94e2ce4b301f1a98a8ab6e39b7771c01c08f227', 'Results', 44, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('1cca3e078aab2d369ce002302388e6908cf6e1905b6c6c67c3a5e4bcea83579a', 'As an example, the analysis of the (ii) Limited Understanding of Lithology Distribution, shown in
Figure 4, is performed using heatmaps. The heatmaps show the distribution of clastic and carbonates
across the Bonaparte Basin and identify patterns and anomalies present in the area. The result can be
supported by the stratigraphic chart where the carbonate environment occurs in the younger formation
from Cretaceous to Neogene period, whereas clastic environment is present in the older formations from
Triassic to Cretaceous.', 45, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e985b4f63b6407bf2af19cb86d8ee47574e46a5e99377cece9a86178099ee8c4', 'Basal vanegrassive enadetone Limeston:
and marine shelf sand mestone
HE arine claystone and shale', 46, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('0bcad9925a33a09db4bd2df8850061c1ecf2796a346ecc890ac49d728a407788', 'Moditied from Frankowlez & McClay 2009', 47, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('0bd9f37175447bc7be7df13b898691a007df0b17d037e678772016dbd86e6f8c', 'Figure 4 Lithology distribution on heatmaps (left) and corresponding stratigraphic chart (right).', 48, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('a7692128f9cb69448e99070bb9ff61a8e7cefcade3b30aad7b8bddb0e23911e0', 'The analysis of the (iii) Limited Mineral Composition Understanding, shown in Figure 5, utilizes the
thin section automatically extracted using ML classification over the full area and suggests that:', 49, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('71e6b2d9732c400c1c89c47a8cb395e59f8893c96a06ba986fd83d9be13f9034', 'Quartz overgrowth and kaolinite are quite common in Bonaparte Basin', 50, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('548be48259c406a3f528ece2d99a48200c3321029a109cf406c9032615b0d90f', 'Mica mineral can be observed at the north-eastern part of the basin', 51, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f0f35b5940243903ab846c9c97440733c97887269f49898c495ac21a5a434ebd', 'Highly corroded, skeletal feldspar has been extensively dissolved, which forms secondary
porosity, and can be observed in the northern part of the basin', 52, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('b9653be09732a7376e8ec6f9571562c241852fac478c88178600dda06101a77d', 'Some patchy siderites are also observed in the southern part of the basin', 53, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e6d5c25860599238ccf8304ec5d5491be8b93d55dfaaacd82631beafcb146ab9', '', 54, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('65462ff8f5ebccbb902c72239bb73e8ae587eba45be49acea912e80485c48022', 'stam (cone
Figure 5 Thin section images distributed on a map across the Bonaparte Basin.', 55, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('63c2c0ea0489dc60810b2da97f5c112bc285dc0f709ce80aad0727fc2c03895a', 'Conclusion', 56, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('b37c57b85843190c8f177b32e9e3c0e4168ad28d4a66307d3962feb82af3db68', 'A regional understanding is critical and time consuming as it involves dealing with a very large data', 57, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('c69a4ad108574a93c6db6232e934e793d03dabed1f28145ea544a32bc7f55b2d', 'volume. Within a project time frame, based on PBE pyramid, the time spent at the Basin Focus stage', 58, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('c71d04b6006b14bfe1937cb549a2ac8a5d11039de568754d89b2ea2e3c0b8095', 'can be reduced, and more time are available to focus on the other project stages. The explorationist will
be able to bring more value to the study.', 59, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('a664e1a5c22d18bcd8b61e0a5daa69b231927fceb1dc5f8c31e5bb34018a40d3', 'ML applications have proven to be able to play a crucial part in order to organize large unstructured
data corpuses. This allows faster and accurate decision making within the fast-moving industry.', 60, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('7ae7e5cdb7c51a8d08a2f20951d5afc428f3cc43d0ea69f02356fe60492143fb', 'In this study, some potential issues encountered during exploration of the Bonaparte Basin can be
identified. Based on a quick look and gathering of all information it can be concluded that most of the
production in the Bonaparte Basin is from Jurassic and Triassic with observed net pay ~18-60m
thickness, porosity ~11-29% and saturation ~11-55% Sw.', 61, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('f9d56133c1b4d9f9441d593fee31a00a8638a97066283e0883d48be23dc5bcbc', 'Hernandez N., Lucafias P., Graciosa J.C., Mamador C., and Panganiban L. C. I, 2019: Automated
information retrieval from unstructured documents utilizing a sequence of smart machine learning
methods within a hybrid cloud container. EAGE Workshop on Big Data and Machine Learning for E&P
Efficiency 25 - 27 February.', 63, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('30833914b6ebd8717b92e7129dc990d71f2e739ac5d332ec98e4e0eda51963cc', 'Lottaroli F., Craig J., Cozzi A., 2016: Evaluating a vintage play fairway exercise using subsequent
exploration results: did it work? Petroleum Geoscience, Vol 24, no 2, p. 159  171.', 64, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e5b18b9446a6c3ab814872cde98287aed0555fe7fc1de0107bf4612440be9468', 'Maver K.G., Hernandez N., Lucafias P., Graciosa J.C., Mamador C., Panganiban L.C.L, Yu C., and
Maver M.G., 2018: An automated information retrieval platform for unstructured well data smart
machine learning algorithms within a hybrid cloud container. EAGE/PESGB Workshop on Machine
Learning, 29  30 November.', 65, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');
INSERT INTO public.chunks VALUES ('e4f502a7b56fe72595b20e78cb5bbd8d73057c0c292358cd88fb32e22481bc64', '
', 66, 'd1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11');


--
-- TOC entry 3356 (class 0 OID 24753)
-- Dependencies: 215
-- Data for Name: paper_titles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paper_titles VALUES ('c5c0a2cd540d43eb6c442963fb9e7b2b139df80aea9c73211085b4ecbe82177a', 'War of the Worlds', '{"H.G. Wells"}', 'War of the Worlds.pdf', '{"Science Fiction",1800s}');
INSERT INTO public.paper_titles VALUES ('8c941b1518412bff0d533886d431b90fa0fb36f51275d2f0d145ab17cb94e740', 'Automated Information Retrieval', '{"N.M Hernandez","P.J. Lucafias","J.C. Graciosa"}', 'Automated_Info_Retrieval.pdf', '{"Machine Learning",Iraya,Documents}');
INSERT INTO public.paper_titles VALUES ('d1df5e57a8004a06ef4324a45d48d9574e00034425a7ce3397ce769a4937cc11', 'A Case Study of Understanding the Bonaparte Basin', '{A.N.Sazali,"N.M. Hernandez","F. Baillard","K.G. Maver"}', 'Bonaparte_Paper.pdf', '{"Case Study","Machine Learning",Iraya,Documents,Geology}');


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 216
-- Name: chunks_chunk_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chunks_chunk_order_seq', 1, false);


--
-- TOC entry 3211 (class 2606 OID 24768)
-- Name: chunks chunks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chunks
    ADD CONSTRAINT chunks_pkey PRIMARY KEY (hash_string);


--
-- TOC entry 3209 (class 2606 OID 24759)
-- Name: paper_titles paper_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paper_titles
    ADD CONSTRAINT paper_titles_pkey PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 24769)
-- Name: chunks chunks_paper_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chunks
    ADD CONSTRAINT chunks_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.paper_titles(id);


-- Completed on 2024-07-08 09:44:21

--
-- PostgreSQL database dump complete
--

